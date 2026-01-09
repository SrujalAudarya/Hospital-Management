
package com.srujal.model;

public class Doctor {
    private int doctor_id;
    private String doctor_name;
    private String email;
    private String password;
    private String contact;
    private int dept_id;

    public Doctor() {
    }

    public Doctor(int doctor_id, String doctor_name, String email, String password, String contact, int dept_id) {
        this.doctor_id = doctor_id;
        this.doctor_name = doctor_name;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.dept_id = dept_id;
    }

    public Doctor(int doctor_id, String doctor_name, String email, String password, String contact) {
        this.doctor_id = doctor_id;
        this.doctor_name = doctor_name;
        this.email = email;
        this.password = password;
        this.contact = contact;
    }

    public Doctor(String doctor_name, String email, String password, String contact) {
        this.doctor_name = doctor_name;
        this.email = email;
        this.password = password;
        this.contact = contact;
    }

    @Override
    public String toString() {
        return "Doctor{" + "doctor_id=" + doctor_id + 
                ", doctor_name=" + doctor_name + 
                ", email=" + email + 
                ", password=" + password + 
                ", contact=" + contact + 
                ", dept_id=" + dept_id + '}';
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public String getDoctor_name() {
        return doctor_name;
    }

    public void setDoctor_name(String doctor_name) {
        this.doctor_name = doctor_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public int getDept_id() {
        return dept_id;
    }

    public void setDept_id(int dept_id) {
        this.dept_id = dept_id;
    }
    
    
}
