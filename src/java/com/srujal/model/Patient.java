
package com.srujal.model;

public class Patient {
   private int patient_id;
   private String patient_name;
   private String email;
   private String password;
   private String contact;
   private String gender;
   private String address;

    public Patient(int patient_id, String patient_name, String email, String password, String contact, String gender, String address) {
        this.patient_id = patient_id;
        this.patient_name = patient_name;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.gender = gender;
        this.address = address;
    }

    public Patient(String patient_name, String email, String password, String contact, String gender, String address) {
        this.patient_name = patient_name;
        this.email = email;
        this.password = password;
        this.contact = contact;
        this.gender = gender;
        this.address = address;
    }

    public Patient() {
    }

    @Override
    public String toString() {
        return "Patient{" + "patient_id=" + patient_id + ", "
                + "patient_name=" + patient_name + ", "
                + "email=" + email + ", "
                + "password=" + password + ", "
                + "contact=" + contact + ", "
                + "gender=" + gender + ", "
                + "address=" + address + '}';
    }

    public int getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(int patient_id) {
        this.patient_id = patient_id;
    }

    public String getPatient_name() {
        return patient_name;
    }

    public void setPatient_name(String patient_name) {
        this.patient_name = patient_name;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
   
   
}
