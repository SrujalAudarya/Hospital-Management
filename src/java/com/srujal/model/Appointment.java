
package com.srujal.model;

public class Appointment {
    private int appointment_id;
    private String appointment_date;
    private String appointment_time;
    private int doctor_id;
    private int patient_id;
    private String status;

    public Appointment() {
    }

    public Appointment(int appointment_id, String appointment_date, String appointment_time, int doctor_id, int patient_id, String status) {
        this.appointment_id = appointment_id;
        this.appointment_date = appointment_date;
        this.appointment_time = appointment_time;
        this.doctor_id = doctor_id;
        this.patient_id = patient_id;
        this.status = status;
    }

    @Override
    public String toString() {
        return "Appointment{" + "appointment_id=" + appointment_id + ", "
                + "appointment_date=" + appointment_date + ", "
                + "appointment_time=" + appointment_time + ", "
                + "doctor_id=" + doctor_id + ", "
                + "patient_id=" + patient_id + ", "
                + "status=" + status + '}';
    }

    public int getAppointment_id() {
        return appointment_id;
    }

    public void setAppointment_id(int appointment_id) {
        this.appointment_id = appointment_id;
    }

    public String getAppointment_date() {
        return appointment_date;
    }

    public void setAppointment_date(String appointment_date) {
        this.appointment_date = appointment_date;
    }

    public String getAppointment_time() {
        return appointment_time;
    }

    public void setAppointment_time(String appointment_time) {
        this.appointment_time = appointment_time;
    }

    public int getDoctor_id() {
        return doctor_id;
    }

    public void setDoctor_id(int doctor_id) {
        this.doctor_id = doctor_id;
    }

    public int getPatient_id() {
        return patient_id;
    }

    public void setPatient_id(int patient_id) {
        this.patient_id = patient_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
