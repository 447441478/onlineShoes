package net.hncu.onlineShoes.shoes.service;

import org.springframework.stereotype.Service;

import net.hncu.onlineShoes.domain.Comment;

@Service("commnetService")
public interface CommnetService {
	
	String commitComment(Comment comment);
}
