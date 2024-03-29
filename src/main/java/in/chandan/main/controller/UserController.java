package in.chandan.main.controller;

import in.chandan.main.entity.Address;
import in.chandan.main.entity.Cart;
import in.chandan.main.entity.User;
import in.chandan.main.repository.AddressRepo;
import in.chandan.main.repository.CartRepo;
import in.chandan.main.repository.UserRepo;
import in.chandan.main.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @Autowired
    CartRepo cartRepo;

    @Autowired
    AddressRepo addressRepo;

    @Autowired
    UserRepo userRepo;



    @GetMapping("/signup")
    public String openSignupPage() {
        return "signup";
    }

    @GetMapping("/login")
    public String openLoginPage() {
        return "login";
    }

    @PostMapping("/signup")
    public String signupUser(@ModelAttribute User user)
    {
        userService.signUpUser(user);
        return "login";
    }

    @PostMapping("/login")
    public String signInUser(@RequestParam("email")String email, @RequestParam("password") String password, HttpSession session){
        User user = userService.signInUser(email, password);
        if (user == null) {
            return "login";
        }
        List<Address> addresses = addressRepo.findByUser(user);
        session.setAttribute("addressList", addresses);
        session.setAttribute("currentUser", user);
        session.setAttribute("items", user.getCart().getCartItems().size());
        return "redirect:/home";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }


    @GetMapping("/profile")
    public String openProfilePage(HttpSession session) {
        User user = (User) session.getAttribute("currentUser");
        if (user == null) return "redirect:/login";
        return "profile";
    }
    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("fname") String fname,
                                @RequestParam("lname") String lname,
                                @RequestParam("email") String email,
                                @RequestParam("phone") String phone,
                                HttpSession session
    )
    {
        User user = (User) session.getAttribute("currentUser");
        user.setFname(fname);
        user.setLname(lname);
        user.setEmail(email);
        user.setPhone(phone);
        userRepo.save(user);
        return "redirect:/profile";
    }
}
