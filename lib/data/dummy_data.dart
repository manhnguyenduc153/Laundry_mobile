import '../models/store.dart';
import '../models/blog.dart';
import '../models/order.dart';

class DummyData {
  static List<Store> stores = [
    Store(
      id: '1',
      name: 'Giặt Ủi Sạch Đẹp',
      image: 'assets/images/tiemgiat1.jpg',
      rating: 4.5,
      description: 'Dịch vụ giặt ủi chuyên nghiệp, giao nhận tận nơi',
      address: '123 Nguyễn Huệ, Q1, Hà Nội',
      services: ['Giặt ủi', 'Giặt khô', 'Giao nhận tận nơi', 'Giặt thảm', 'Giặt rèm cửa', 'Giặt chăn ga gối đệm'],
    ),
    Store(
      id: '2',
      name: 'Giặt Khô Cao Cấp',
      image: 'assets/images/tiemgiat2.jpg',
      rating: 4.8,
      description: 'Chuyên giặt khô quần áo cao cấp, vest, áo dài',
      address: '456 Lê Lợi, Q1, Hà Nội',
      services: ['Giặt khô', 'Giặt vest', 'Giặt áo dài', 'Giặt áo khoác da', 'Sửa chữa quần áo', 'Loại vết bẩn chuyên sâu'],
    ),
    Store(
      id: '3',
      name: 'Giặt Ủi Nhanh 24h',
      image: 'assets/images/tiemgiat3.jpg',
      rating: 4.2,
      description: 'Giặt nhanh trong 24h, giá rẻ, chất lượng',
      address: '789 Trần Hưng Đạo, Hà Nội',
      services: ['Giặt nhanh 24h', 'Giặt ủi', 'Giá rẻ', 'Giặt sấy khô', 'Giặt quần áo trẻ em', 'Dịch vụ khử trùng'],
    ),
    Store(
      id: '4',
      name: 'Giặt Ủi Gia Đình',
      image: 'assets/images/tiemgiat4.jpg',
      rating: 4.0,
      description: 'Dịch vụ giặt ủi cho gia đình, giá ưu đãi',
      address: '321 Võ Văn Tần, Q3, Hà Nội',
      services: ['Giặt ủi gia đình', 'Giá ưu đãi', 'Giao nhận', 'Giặt đồ sơ sinh', 'Giặt đồ thể thao', 'Gói giặt theo tháng'],
    ),
  ];

  static List<Blog> blogs = [
    Blog(
      id: '1',
      title: '5 Mẹo giữ quần áo luôn thơm tốt',
      image: 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=800',
      preview: 'Học cách bảo quản tủ quần áo của bạn...',
      content: '''Giữ quần áo luôn sạch sẽ và thơm tốt là điều quan trọng để duy trì vẻ ngoài chuyên nghiệp và kéo dài tuổi thọ quần áo. Dưới đây là 5 mẹo hữu ích từ các chuyên gia:

1. Phân loại quần áo đúng cách
Luôn tách riêng quần áo trắng, màu và vải mỏng. Điều này giúp tránh lẫn màu và đảm bảo từng loại vải được chăm sóc đúng cách. Quần áo thể thao nên giặt riêng để tránh mùi khó chịu lan sang quần áo khác. Đồ lót và tất cũng nên được giặt riêng vì lý do vệ sinh.

2. Sử dụng nhiệt độ nước phù hợp
Nước lạnh (dưới 30°C) tốt nhất cho hầu hết quần áo và tiết kiệm năng lượng. Dùng nước ấm (40-60°C) cho quần áo trắng, khăn tắm và đồ bẩn nhiều. Nước nóng (trên 60°C) chỉ dùng cho vải cotton trắng và khi cần khử trùng. Luôn kiểm tra nhãn giặt trước khi giặt.

3. Không cho quá nhiều quần áo vào máy giặt
Để quần áo có không gian di chuyển tự do trong lồng giặt. Cho quá nhiều sẽ không giặt sạch, tăng mòn quần áo và có thể làm hỏng máy giặt. Quy tắc chung là chỉ nên đổ đầy 3/4 dung tích lồng giặt. Với quần áo nặng như chăn, áo khoác mùa đông, chỉ nên đổ  1/2 lồng giặt.

4. Phơi khô tự nhiên khi có thể
Phơi khô ngoài trời nhẹ nhàng hơn với vải, giúp quần áo bền lâu hơn và tiết kiệm điện. Ánh nắng mặt trời còn có tác dụng khử trùng tự nhiên. Tránh phơi quần áo màu dưới nắng gắt để không bị phai màu. Quần áo len nên phơi nằm ngang trên giá để tránh giãn.

5. Bảo quản đúng cách
Dùng móc treo phù hợp: móc rộng cho áo sơ mi, móc có kẹp cho váy và quần. Gấp quần áo len nặng để tránh giãn. Giữ tủ quần áo gọn gàng, thông thoáng và khô ráo. Dùng túi thơm hoặc các sản phẩm hút ẩm để giữ tủ không bị mốc. Quần áo mùa không mặc nên giặt sạch và cất trong hộp kín.

Thực hiện những mẹo đơn giản này sẽ giúp quần áo của bạn luôn mới và đẹp trong nhiều năm. Nếu bạn không có thời gian hoặc thiết bị phù hợp, hãy tin tưởng dịch vụ giặt ủi chuyên nghiệp để đảm bảo quần áo luôn được chăm sóc tốt nhất!''',
      author: 'Nguyễn Thị Lan',
      date: '15/05/2024',
    ),
    Blog(
      id: '2',
      title: 'Lợi ích của dịch vụ giặt khô chuyên nghiệp',
      image: 'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=800',
      preview: 'Khám phá tại sao giặt khô chuyên nghiệp đáng giá...',
      content: '''Dịch vụ giặt khô chuyên nghiệp mang lại nhiều lợi ích vượt trội so với giặt tại nhà. Dưới đây là lý do tại sao nó đáng đầu tư:

Loại bỏ vết bẩn chuyên nghiệp
Thợ giặt chuyên nghiệp có sản phẩm và kỹ thuật chuyên dụng để loại bỏ vết bẩn khó mà không làm hỏng vải.

Chăm sóc vải
Vải mỏng như lụa, len và cashmere cần chăm sóc đặc biệt mà giặt khô cung cấp hoàn hảo.

Tiết kiệm thời gian
Gửi quần áo đi và nhận lại sạch sẽ, đã ủi, sẵn sàng mặc. Không còn phải dành cuối tuần để giặt giũ!

Ủi chuyên nghiệp
Có vẻ ngoài sắc nét, chuyên nghiệp khó đạt được ở nhà.

Kéo dài tuổi thọ quần áo
Chăm sóc đúng cách có nghĩa là quần áo bền lâu hơn, tiết kiệm tiền về lâu dài.

Tin tưởng chuyên gia với những trang phục quý giá của bạn và tận hưởng sự tiện lợi và chất lượng của dịch vụ giặt khô chuyên nghiệp!''',
      author: 'Trần Văn Minh',
      date: '10/05/2024',
    ),
    Blog(
      id: '3',
      title: 'Thực hành giặt giũ thân thiện với môi trường',
      image: 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=800',
      preview: 'Cách làm cho việc giặt giũ bền vững hơn...',
      content: '''Làm cho việc giặt giũ thân thiện với môi trường dễ dàng hơn bạn nghĩ. Dưới đây là các cách thực tế để giảm tác động môi trường:

Dùng nước lạnh
Giặt bằng nước lạnh tiết kiệm năng lượng và hiệu quả như nhau cho hầu hết quần áo.

Chọn bột giặt thân thiện
Tìm bột giặt phân hủy sinh học, không chứa phosphate, nhẹ nhàng với môi trường.

Giặt đầy tải
Đợi cho đến khi có đủ quần áo để tối đa hóa hiệu quả sử dụng nước và năng lượng.

Phơi khô tự nhiên khi có thể
Bỏ qua máy sấy và để mặt trời làm việc. Miễn phí và tốt hơn cho quần áo.

Dùng bóng giặt tái sử dụng
Thay thế giấy thơm vải bằng bóng giặt len để giảm rác thải và làm mềm quần áo tự nhiên.

Chọn dịch vụ giặt xanh
Nhiều tiệm giặt chuyên nghiệp giờ cung cấp tùy chọn thân thiện với môi trường với thực hành bền vững.

Những thay đổi nhỏ trong thói quen giặt giũ có thể tạo ra sự khác biệt lớn cho hành tinh của chúng ta!''',
      author: 'Lê Thị Hương',
      date: '05/05/2024',
    ),
  ];

  static List<Order> orders = [
    Order(
      id: 'ORD001',
      storeName: 'Fresh Clean Laundry',
      serviceType: 'Wash & Fold',
      date: 'May 20, 2024',
      status: 'Completed',
      price: 25.00,
      storeImage: 'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?w=800',
      services: ['Wash & Fold', 'Ironing'],
    ),
    Order(
      id: 'ORD002',
      storeName: 'Quick Wash Express',
      serviceType: 'Express Service',
      date: 'May 22, 2024',
      status: 'Delivering',
      price: 35.00,
      storeImage: 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=800',
      services: ['Wash & Fold', 'Same Day Service'],
    ),
    Order(
      id: 'ORD003',
      storeName: 'Premium Laundry Care',
      serviceType: 'Dry Cleaning',
      date: 'May 23, 2024',
      status: 'Washing',
      price: 45.00,
      storeImage: 'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?w=800',
      services: ['Dry Cleaning', 'Stain Removal'],
    ),
    Order(
      id: 'ORD004',
      storeName: 'Eco Wash Station',
      serviceType: 'Wash & Fold',
      date: 'May 24, 2024',
      status: 'Pending',
      price: 28.00,
      storeImage: 'https://images.unsplash.com/photo-1610557892470-55d9e80c0bce?w=800',
      services: ['Wash & Fold', 'Organic Detergent'],
    ),
  ];
}
