pragma solidity >= 0.7.0 < 0.9.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Market {

    enum ListingStatus {
        Active,     // Có thể mua
        Sold,       // Đã bán 
        Cancelled   // Đã tháo khỏi chợ
    }

    struct Listing {            // Item trong danh sách
        ListingStatus status;   // Trạng thái của 
        address seller;         // Địa chỉ ví của người bán
        address token;          // Địa chỉ của NFT
        uint tokenId;           // ID của token
        uint price;             // Giá của token trên sàn
    }

    event Listed(
        uint listingId,
        address sender,
        address token,
        uint tokenId,
        uint price
    );

    event Sale(
        uint listingId,
        address sender,
        address token,
        uint tokenId,
        uint price
    );

    event Cancel(
        uint listingId,
        address sender
    );

    // Số lượng NFT đã được đưa lên sàn
    uint private _listingId = 0;
    // Map chứa các NFT
    mapping(uint => Listing) private _listings;



    // Hàm thực hiện lệnh đưa token lên sàn
    function listToken(address token, uint tokenId, uint price) external payable {
        // Chuyển NFT đến địa chỉ của Market
        IERC721(token).transferFrom(msg.sender, address(this), tokenId);
        
        // Tạo một item 
        // Trạng thái NFT là Có thể mua
        // Địa chỉ người bán là ví của người thực hiện lệnh listToken
        Listing memory listing = Listing(
            ListingStatus.Active,
            msg.sender, 
            token, 
            tokenId, 
            price * 1 ether
        );

        // Tăng số lượng NFT đã lên sàn
        _listingId++;
        // Thêm item vào list item có trên sàn
        _listings[_listingId] = listing;

        // Thông báo event đã list sàn
        emit Listed (
            _listingId,
            msg.sender,
            token,
            tokenId,
            price
        );
    }

    function getListing(uint listingId) public view returns (Listing memory) {
        return _listings[listingId];
    }

    // Hàm thực hiện lệnh mua token
    // Lệnh "msg.value" và "callvalue()" chỉ có thể thực hiện nếu 
    //      là hàm "payable" hoặc "internal" hàm
    // Cần lấy số dư trong ví để kiểm tra xem có đủ để mua token
    //      hay không
    function buyToken(uint listingId) external payable{
        // Chọn vào NFT cần mua
        Listing storage listing = _listings[listingId];

        // Người mua phải khác người bán
        // Kiểm tra bằng cách so sánh địa chỉ của người thực hiện lệnh mua
        //      với địa người bán
        // Nếu sai thì thông báo "Người bán không thể là người mua"
        require(msg.sender != listing.seller, "Seller cannot be buyer");

        // Item phải trong trạng thái sẵn sàng để mua
        // Nếu sản phẩm không trong trạng thái có thể mua
        //      thông báo "Danh sách không hoạt động
        require(listing.status == ListingStatus.Active, "Listing is not active");
        
        // Số tiền trong ví người mua phải lớn hơn hoặc bằng
        //      với giá của NFT, nếu không
        //      thông báp "Không đủ để thanh toán"  
        require(msg.value >= listing.price, "Insufficient payment");

        // Chuyển trạng thái NFT về đã mua
        listing.status = ListingStatus.Sold;
        
        // Nếu tất cả các kiểm tra trên đúng nghĩa là người dùng đủ
        //      điều kiện mua, ta chuyển token đến ví của người mua
        IERC721(listing.token).transferFrom(address(this), msg.sender, listing.tokenId);

        // Chuyển tiền cho người bán token
        // Số tiền chuyển bằng với giá token lúc list sàn
        // Người mua nhận lại 99% giá trị của NFT, 1% sàn sẽ giữ
        //      lại coi như là tiền phí
        payable(listing.seller).transfer(listing.price * 99 / 100);


        // Thông báo event đã bán
        emit Sale (
            listingId,
            msg.sender,
            listing.token,
            listing.tokenId,
            listing.price
        );
    } 

    // Hàm thu hồi NFT khỏi list
    function cancel(uint listingId) public {
        // Chọn vào NFT cần bỏ khỏi sàn
        Listing storage listing = _listings[listingId];
        
        // Người hủy NFT khỏi list phải là người bán
        // Nếu không, thông báo "Chỉ người bán mới 
        //      có thể hủy bỏ danh sách"
        require(msg.sender == listing.seller, "Only seller can cancel listing");
        // NFT phải đang ở trạng thái sẵn sàng
        // Nếu không, thông báo "Danh sách không hoạt động"
        require(listing.status  == ListingStatus.Active, "Listing is not active");

        // Nếu kiểm tra tất cả thành công
        // Trạng thái của NFT trên sàn trở thành đã đưa về ví
        listing.status = ListingStatus.Cancelled;

        // NFT được trả về ví người bán
        IERC721(listing.token).transferFrom(address(this), msg.sender, listing.tokenId);

        // Thông báo event đã cancel
        emit Cancel(listingId, listing.seller);
    }
}