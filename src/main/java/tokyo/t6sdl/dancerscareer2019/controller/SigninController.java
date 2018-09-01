package tokyo.t6sdl.dancerscareer2019.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import tokyo.t6sdl.dancerscareer2019.httpresponse.NotFound404;
import tokyo.t6sdl.dancerscareer2019.model.EmailForm;
import tokyo.t6sdl.dancerscareer2019.model.PasswordForm;
import tokyo.t6sdl.dancerscareer2019.service.AccountService;
import tokyo.t6sdl.dancerscareer2019.service.MailService;
import tokyo.t6sdl.dancerscareer2019.service.SecurityService;

@Controller
@RequestMapping("/signin")
public class SigninController {
	private final AccountService accountService;
	private final SecurityService securityService;
	private final MailService mailService;
	
	public SigninController(AccountService accountService, SecurityService securityService, MailService mailService) {
		this.accountService = accountService;
		this.securityService = securityService;
		this.mailService = mailService;
	}
	
	@GetMapping
	public String getSignin() {
		return "signin/signinForm";
	}
	
	@PostMapping
	public String postSignin() {
		return "redirect:/";
	}
	
	@GetMapping("/forget-pwd")
	public String getFogetPassword(@RequestParam(name = "token", required = false) String token, Model model) {
		if (token == "" || token == null) {
			model.addAttribute(new EmailForm());
			return "signin/forgetPassword";
		} else if (accountService.isValidPasswordToken(token)) {
			model.addAttribute(new PasswordForm());
			model.addAttribute("token", token);
			return "signin/resetPassword";
		} else {
			throw new NotFound404();
		}
	}
	
	@PostMapping("/forget-pwd")
	public String postForgetPassword(@Validated EmailForm form, BindingResult result, Model model) {
		if (result.hasErrors()) {
			return "signin/forgetPassword";
		}
		String passwordToken = accountService.createPasswordToken(form.getEmail());
		mailService.sendMailWithUrl(form.getEmail(), MailService.SUB_RESET_PWD, MailService.CONTEXT_PATH + "/signin/forget-pwd?token=" + passwordToken);
		return "signin/sentEmail";
	}
		
	@PostMapping("/reset-pwd")
	public String postResetPassword(@Validated PasswordForm form, BindingResult result, @RequestParam("token") String token, Model model) {
		if (result.hasErrors()) {
			model.addAttribute("token", token);
			return "signin/resetPassword";
		}
		String email = accountService.completeResetPassword(token);
		accountService.changePassword(email, form.getPassword());
		return "signin/completeResetPassword";
	}
}