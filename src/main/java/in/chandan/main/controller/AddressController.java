package in.chandan.main.controller;

import in.chandan.main.entity.Address;
import in.chandan.main.entity.User;
import in.chandan.main.repository.AddressRepo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Controller
public class AddressController {

    @Autowired
    AddressRepo addressRepo;

    @PostMapping("/update-address")
    public String updateAddressFromProfile(
            @RequestParam("houseno") String houseno,
            @RequestParam("locality") String locality,
            @RequestParam("pincode") String pincode,
            @RequestParam("state") String state,
            @RequestParam("district") String district,
            @RequestParam("addressId") String addressId,
            HttpServletRequest request,
            HttpSession session
    )
    {
        System.out.println("My address id is : " + addressId);
        User user = (User) session.getAttribute("currentUser");
        List<Address> addressList = addressRepo.findByUser(user);

        for (Address address : addressList) {
            if (address.getId() == Integer.parseInt(addressId)) {
                address.setHouseNo(houseno);
                address.setLocality(locality);
                address.setPincode(pincode);
                address.setDistrict(district);
                address.setUser(user);
                address.setState(state);
                addressRepo.save(address);
            }
        }
        List<Address> addresses = addressRepo.findByUser(user);
        session.setAttribute("addressList", addresses);
        String referrer = request.getHeader("referer");
        return "redirect:"+referrer;
    }

    @GetMapping("/addresses")
    public String openManageAddressPage(HttpSession session) {
        User user  = (User) session.getAttribute("currentUser");
        if (user == null) {
            return "redirect:/login";
        }
        List<Address> addresses = addressRepo.findByUser(user);
        session.setAttribute("addressList", addresses);
        return "address";
    }
    @PostMapping("/add-new-address")
    public String addNewAddress(@ModelAttribute Address address,
            @RequestParam("houseno") String houseno,
            HttpServletRequest request,
            HttpSession session
    )
    {
        User user = (User) session.getAttribute("currentUser");
        address.setUser(user);
        address.setHouseNo(houseno);
        System.out.println(address.toString());
        addressRepo.save(address);
        List<Address> addresses = addressRepo.findByUser(user);
        session.setAttribute("addressList", addresses);
        String referrer = request.getHeader("referer");
        return "redirect:"+referrer;
    }

    @Transactional
    @PostMapping("/delete-address")
    public String deleteAddress(@RequestParam("addressId") String addressId) {
        Address address = addressRepo.findById(Integer.parseInt(addressId)).get();
        address.setUser(null);
        return "redirect:/addresses";
    }

    @GetMapping("/api/pincode/{pincode}")
    @ResponseBody
    public Object getDetails(@PathVariable String pincode) {
        System.out.println(pincode);
        final String url = "http://postalpincode.in/api/pincode/" + pincode;
        RestTemplate restTemplate = new RestTemplate();
        return restTemplate.getForObject(url, Object.class);
    }

}
