package ga.graph;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import ga.dao.Point;

public class Readimage {
	
	public Readimage(int small) {
		super();
		this.small = small;
	}
	private int small;
	private int width;
	private int height;
	
	public Point[] getImagePixelToArray(String image) throws Exception {
		int[] rgb = new int[3];
		File file = new File(image);
		BufferedImage bi = null;
		try {
			bi = ImageIO.read(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int width = bi.getWidth();
		int height = bi.getHeight();
		int minx = bi.getMinX();
		int miny = bi.getMinY();
		Point[] ps = new Point[width*height];
		int index = 0;
		for (int i = minx; i < width; i++) {
			if(i%small!=0) continue;
			for (int j = miny; j < height; j++) {
				int pixel = bi.getRGB(i, j);
				rgb[0] = (pixel & 0xff0000) >> 16;
				rgb[1] = (pixel & 0xff00) >> 8;
				rgb[2] = (pixel & 0xff);
				if(j%small!=0) continue;
				if(rgb[0]==rgb[1]&&rgb[1]==rgb[2]&&rgb[0]==255) {
					continue;
				}else {
					ps[index++] = new Point(i/small,j/small,rgb);
				}
			}
		}
		System.out.println(index+"\t"+ps[1].getY());
		Point[] point = new Point[index];
		System.arraycopy(ps, 0, point, 0, index);
		System.out.println("width=" + width + ",height=" + height + ".");
		this.width = width/small;
		this.height = height/small;
		System.out.println("width=" + this.width + ",height=" + this.height + ".");
		return point;
	}
	
	public void writeImage(Point[] ps) {
		BufferedImage newImage = new BufferedImage(width+1,height+1,BufferedImage.TYPE_INT_ARGB);
		Graphics g = newImage.getGraphics();
		g.setColor(new Color(0,0,0));
		for(Point p :ps) {
			g.drawOval(p.getX(), p.getY(), 1, 1);
		}
		g.dispose();
		boolean val = false;
		try {
			val = ImageIO.write(newImage, "png", new File("resource/test3.png"));
			if(val==false) {
				System.out.println(val);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void writeImage(Point[] ps, String addr) {
		BufferedImage newImage = new BufferedImage(width+1,height+1,BufferedImage.TYPE_INT_ARGB);
		Graphics g = newImage.getGraphics();
		g.setColor(new Color(0,0,0));
		for(Point p :ps) {
			g.drawOval(p.getX(), p.getY(), 1, 1);
		}
		g.dispose();
		boolean val = false;
		try {
			val = ImageIO.write(newImage, "png", new File(addr));
			System.out.println(val);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}

}
