package in.chandan.main.controller;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import in.chandan.main.entity.*;
import in.chandan.main.repository.*;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    AddressRepo addressRepo;

    @Autowired
    OrderItemRepo orderItemRepo;

    @Autowired
    CartItemRepo cartItemRepo;

    @Autowired
    MyOrderRepo myOrderRepo;

    @Autowired
    CartRepo cartRepo;

    @GetMapping("/place-order")
    public String openCartCheckoutPage(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        List<Address> addressList = addressRepo.findByUser(user);
        session.setAttribute("address", addressList);
        Cart cart = cartRepo.findById(user.getCart().getId()).get();
        session.setAttribute("cartItemList", cart.getCartItems());
        return "cart-checkout";
    }




    @PostMapping("/confirm-checkout")
    @ResponseBody
    public MyOrder confirmCheckout(@RequestBody Map<String, Object> req, HttpSession session) throws RazorpayException {
        System.out.println(req.get("cartItemsId") + "my cart items id");
        MyOrder myOrder = new MyOrder();
        User user = (User) session.getAttribute("currentUser");
        List<OrderItem> orderItems = myOrder.getOrderItems();
        @SuppressWarnings("unchecked")
        List<String> cartItemsIdList = (List<String>) req.get("cartItemsId");
        System.out.println("cartItemsIdList size is : " + cartItemsIdList.size());
        for (String id : cartItemsIdList) {
            CartItem cartItem = cartItemRepo.findById(Integer.parseInt(id)).get();
            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItemRepo.save(orderItem);
            orderItems.add(orderItem);
        }

        RazorpayClient razorpay = new RazorpayClient("rzp_test_z5yVWa8008Y4t2", "7nWA2fzmoPlAyRyxJUQH5BLd");
        int amt = Integer.parseInt(req.get("totalAmount").toString());
        JSONObject orderRequest = new JSONObject();
        orderRequest.put("amount",amt*100);
        orderRequest.put("currency","INR");
        orderRequest.put("receipt", "receipt#1");
        Order order = razorpay.orders.create(orderRequest);

        myOrder.setOrderItems(orderItems);
        myOrder.setUser(user);
        myOrder.setStatus("created");
        myOrder.setOrderId(order.get("id"));
        myOrderRepo.save(myOrder);

        session.setAttribute("order", order);

        return myOrder;
    }

    @PostMapping("/updateOrder")
    public String handlePostRequest(@RequestBody Map<String, Object> data, HttpSession session) {
        // Handle the received data
        System.out.println("My order id is : " + data.get("order_id").toString());
        MyOrder myOrder = myOrderRepo.findByOrderId(data.get("order_id").toString());
        myOrder.setPaymentId(data.get("payment_id").toString());
        myOrder.setStatus("paid");

        Address address = addressRepo.findById(Integer.parseInt(data.get("addressId").toString())).get();
        myOrder.setAddress(address);
        myOrderRepo.save(myOrder);
        System.out.println("my addressid is : " + data.get("addressId"));

        User user = (User) session.getAttribute("currentUser");
        Cart cart = user.getCart();
        List<CartItem> cartItems = cart.getCartItems();
        cartItemRepo.deleteAllInBatch(cartItems);
        cartItems.clear();
        cart.setCartItems(cartItems);
        cartRepo.save(cart);
        session.setAttribute("items", 0);

        return "redirect:/cart";
    }

    @GetMapping("/confirmation_page")
    public String openconfirmationPage() {
        return "confirmation_page";
    }

    @GetMapping("/myorders")
    public String openMyOrdersPage(HttpSession session) {
        User user  = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }
        List<MyOrder> myOrderList = myOrderRepo.findByUser(user);
        session.setAttribute("myOrderList", myOrderList);
        return "myOrders";
    }
}
