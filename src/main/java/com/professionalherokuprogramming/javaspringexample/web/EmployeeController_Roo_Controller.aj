// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.professionalherokuprogramming.javaspringexample.web;

import com.professionalherokuprogramming.javaspringexample.domain.Employee;
import com.professionalherokuprogramming.javaspringexample.web.EmployeeController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect EmployeeController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String EmployeeController.create(@Valid Employee employee, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, employee);
            return "employees/create";
        }
        uiModel.asMap().clear();
        employee.persist();
        return "redirect:/employees/" + encodeUrlPathSegment(employee.getId_().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String EmployeeController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Employee());
        return "employees/create";
    }
    
    @RequestMapping(value = "/{id_}", produces = "text/html")
    public String EmployeeController.show(@PathVariable("id_") Long id_, Model uiModel) {
        uiModel.addAttribute("employee", Employee.findEmployee(id_));
        uiModel.addAttribute("itemId", id_);
        return "employees/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String EmployeeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("employees", Employee.findEmployeeEntries(firstResult, sizeNo));
            float nrOfPages = (float) Employee.countEmployees() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("employees", Employee.findAllEmployees());
        }
        return "employees/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String EmployeeController.update(@Valid Employee employee, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, employee);
            return "employees/update";
        }
        uiModel.asMap().clear();
        employee.merge();
        return "redirect:/employees/" + encodeUrlPathSegment(employee.getId_().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id_}", params = "form", produces = "text/html")
    public String EmployeeController.updateForm(@PathVariable("id_") Long id_, Model uiModel) {
        populateEditForm(uiModel, Employee.findEmployee(id_));
        return "employees/update";
    }
    
    @RequestMapping(value = "/{id_}", method = RequestMethod.DELETE, produces = "text/html")
    public String EmployeeController.delete(@PathVariable("id_") Long id_, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Employee employee = Employee.findEmployee(id_);
        employee.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/employees";
    }
    
    void EmployeeController.populateEditForm(Model uiModel, Employee employee) {
        uiModel.addAttribute("employee", employee);
    }
    
    String EmployeeController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
