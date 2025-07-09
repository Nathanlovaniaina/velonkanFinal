package org.example.service;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import org.example.entity.Presence;
import org.example.repository.PresenceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PresenceService {
    @Autowired
    private PresenceRepository repository;

    
    public List<Presence> findAll() {
        return repository.findAllWithEmployeWithPoste();
    }


    public Presence save(Presence presence) {
        return repository.save(presence);
    }

    public List<Presence> findByDate(LocalDate date) {
        return repository.findByDatePresence(date);
    }


    public void deleteById(Long id) {
        repository.deleteById(Integer.parseInt(id.toString(0)));
    }

}