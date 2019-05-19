package net.hncu.onlineShoes.util;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 * 敏感词过滤工具<br/>
 * 该工具通过 init 函数载入敏感词，
 * 把所有敏感词拆分成一个一个字，然后再组装成多个敏感词树。
 * 通过调用 replaceSensitiveWord 函数将含有敏感词的文本进行替换
 * @author 宋进宇
 *
 */
public class SensitiveWordFilterUtil {
	private SensitiveWordFilterUtil() {
		throw new AssertionError();
	}
	
	private static class Node{
		boolean isEnd;
		Map<Character, Node> nextNodes = new HashMap<>();
	}
	
	private static Map<Character,Node> sensitiveWordMap;
	
	static {
		//初始化敏感词汇集
		Set<String> sensitiveWords = new HashSet<>();
		//按理应该从敏感词库加载数据，这里就简单处理了。
		sensitiveWords.add("共产党");
		sensitiveWords.add("习大大");
		sensitiveWords.add("反共");
		sensitiveWords.add("傻逼");
		sensitiveWords.add("傻子");
		//构建敏感词树
		init(sensitiveWords);
	}
	
	private static void init(Set<String> sensitiveWords) {
		sensitiveWordMap = new HashMap<>(); 
		Iterator<String> iterator = sensitiveWords.iterator();
		while (iterator.hasNext()) {
			String str = iterator.next();
			Map<Character,Node> nowMap = sensitiveWordMap;
			for(int i = 0; i < str.length(); i++) {
				char ch = str.charAt(i);
				Node node = nowMap.get(ch);
				if (node == null) {
					node = new Node();
					nowMap.put(ch, node);
				}
				nowMap = node.nextNodes;
				if (i == str.length()-1) {
					node.isEnd = true;
				}
			}
			
		}
	}
	/**
	 * 把可能含有敏感词汇的文本进行替换
	 * @param text 含有敏感词汇的文本 
	 * @param replacement 代替敏感词的词汇
	 * @return 不带有敏感词的文本
	 */
	public static String replaceSensitiveWord(String text, String replacement) {
		StringBuilder res = new StringBuilder("");
		Node node = null;
		int matchLen = 0;
		int maxReplaceLen = 0;
		Map<Character, Node> nodes = sensitiveWordMap;
		for(int i = 0; i < text.length(); i++) {
			char ch = text.charAt(i);
			node = nodes.get(ch);
			if(node == null) {
				if(maxReplaceLen != 0) {
					res.append(replacement);
				} 
				res.append(text.substring(i-matchLen+maxReplaceLen, i+1));
				matchLen = 0; 
				maxReplaceLen = 0;
				nodes = sensitiveWordMap;
				continue;
			}
			matchLen++;
			if(node.isEnd) {
				maxReplaceLen = matchLen;
			} 
			nodes = node.nextNodes;
		}
		return res.toString();
	}
	
	public static void main(String[] args) {
		/*Set<String> words = new HashSet<>();
		words.add("AB");
		words.add("ABDE");
		words.add("ABF");
		words.add("AC");
		init(words);
		System.out.println(replaceSensitiveWord("ABDFABFIOPK", "***"));*/
	}
	
}
