package com.chinauicom.research.iotoperation.system.reportforms.utils;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelUtils {
	
	/**   
     * 1.创建 workbook   
     * @return   
     */    
	public HSSFWorkbook getHSSFWorkbook() {    
        return new HSSFWorkbook();    
    }
	
	/**   
     * 2.创建 sheet   
     * @param hssfWorkbook   
     * @param sheetName sheet 名称   
     * @return   
     */    
	public HSSFSheet getHSSFSheet(HSSFWorkbook hssfWorkbook, String sheetName) {    
        return hssfWorkbook.createSheet(sheetName);    
    }
	
	/**   
     * 3.写入表头信息   
     * @param hssfWorkbook   
     * @param hssfSheet   
     * @param headInfoList List<String>   
     *              key: title         列标题   
     */    
	public void writeHeader(HSSFWorkbook hssfWorkbook, HSSFSheet hssfSheet, List<String> headInfoList) {  
		//List<Map<String, Object>> headInfoList 
        HSSFCellStyle cs = hssfWorkbook.createCellStyle();    
        HSSFFont font = hssfWorkbook.createFont();    
        font.setFontHeightInPoints((short)12);    
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);    
        cs.setFont(font);    
        cs.setAlignment(HSSFCellStyle.ALIGN_CENTER);    
        cs.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cs.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cs.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cs.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        
        
        HSSFRow r = hssfSheet.createRow(0);    
        r.setHeight((short) 380);    
        HSSFCell c = null;      
        //处理excel表头    
        for(int i=0, len = headInfoList.size(); i < len; i++){    
        	//headInfo = headInfoList.get(i);
        	
            String s = "";
            s = (headInfoList.get(i).toString()).replaceAll("[^\\x00-\\xff]", "**");  
            int length = s.length();  
            hssfSheet.setColumnWidth(i, 350*length);
            c = r.createCell(i);   
            c.setCellValue(headInfoList.get(i).toString());
            //c.setCellValue(headInfoList.get("title").toString());    
            c.setCellStyle(cs);    
            //操作列宽等属性
            /*if(headInfo.containsKey("columnWidth")){    
            	hssfSheet.setColumnWidth(i, (short)(((Integer)headInfo.get("columnWidth") * 8) / ((double) 1 / 20)));    
            }  */  
        }    
    } 
	
	/**   
     * 4.写入内容部分   
     * @param hssfWorkbook   
     * @param hssfSheet   
     * @param startIndex 从1开始，多次调用需要加上前一次的dataList.size()   
     * @param headInfoList List<Map<String, Object>>   
     *              key: title         列标题   
     *                   columnWidth   列宽   
     *                   dataKey       列对应的 dataList item key   
     * @param dataList   
     */    
    public void writeContent(HSSFWorkbook hssfWorkbook,HSSFSheet hssfSheet ,int startIndex,    
            List<String> headInfoList, List<Map<String, Object>> dataList){ 
    	HSSFRow r = null;    
		HSSFCell c = null;    
		HSSFCellStyle cs = hssfWorkbook.createCellStyle();
		cs.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cs.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cs.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cs.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        HSSFCellStyle cs1 = hssfWorkbook.createCellStyle();
		cs1.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        cs1.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        cs1.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        cs1.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        HSSFDataFormat df = hssfWorkbook.createDataFormat();  //此处设置数据格式 
        cs1.setDataFormat(df.getFormat("#,#0.00")); //小数点后保留两位，可以写
		//处理数据    
		Map<String, Object> dataItem = null;    
		Object v = null;    
		for (int i=0, rownum = startIndex, len = (startIndex + dataList.size()); rownum < len; i++,rownum++){    
			r = hssfSheet.createRow(rownum);    
			r.setHeightInPoints(16);    
			dataItem = dataList.get(i);    
			for(int j=0, jlen = headInfoList.size(); j < jlen; j++){    
				c = r.createCell(j);    
				v = dataItem.get(headInfoList.get(j).toString());    
				if (v instanceof String) {    
						c.setCellValue((String)v);    
						c.setCellStyle(cs);
					}else if (v instanceof Boolean) {    
						c.setCellValue((Boolean)v);    
						c.setCellStyle(cs);
					}else if (v instanceof Calendar) {    
						c.setCellValue((Calendar)v);    
						c.setCellStyle(cs);
					}else if (v instanceof Double) {    
						c.setCellValue((Double)v);   
						c.setCellStyle(cs); 
					}else if (v instanceof Integer || v instanceof Long || v instanceof Short || v instanceof Float) {    
						c.setCellValue(Double.parseDouble(v.toString()));    
						c.setCellStyle(cs);
					}else if (v instanceof HSSFRichTextString) {    
						c.setCellValue((HSSFRichTextString)v);    
						c.setCellStyle(cs);
					}else {    
						if (v==null){
							v="";
						}
						c.setCellValue(v.toString());    
						c.setCellStyle(cs);
					}    
			}    
		}    
	}

    public void write2FilePath(HSSFWorkbook hssfWorkbook, String fileName, HttpServletResponse response) throws IOException{
   	 
   	 OutputStream out = null; 
   	 try{
   		 out = response.getOutputStream();  
         response.setContentType("application/x-msdownload");  
         response.setHeader("Content-Disposition", "attachment; filename="+ URLEncoder.encode(fileName, "UTF-8"));
         hssfWorkbook.write(out);  
   	 }catch (Exception e) {  
            e.printStackTrace();  
        } finally {    
            try {     
                out.close();    
            } catch (IOException e) {    
                e.printStackTrace();  
            }    
        }    
    } 
    
    public void write2FilePath(HSSFWorkbook hssfWorkbook, String filePath) throws IOException {
      	 
    	FileOutputStream out = new FileOutputStream(filePath);
      	 try{
            hssfWorkbook.write(out);  
      	 }catch (Exception e) {  
               e.printStackTrace();  
           } finally {    
               try {     
                   out.close();    
               } catch (IOException e) {    
                   e.printStackTrace();  
               }    
           }    
    } 
    
    public static void exportExcel2FilePath(String sheetName, String fileName, List<String> headInfoList, List<String> titleList, List<Map<String, Object>> dataList, HttpServletResponse response) throws IOException { 
    	//List<Map<String, Object>> headInfoList,String filePath
    	ExcelUtils export = new ExcelUtils();     
		//1.创建 Workbook    
		HSSFWorkbook hssfWorkbook = export.getHSSFWorkbook();    
		//2.创建 Sheet    
		HSSFSheet hssfSheet = export.getHSSFSheet(hssfWorkbook, sheetName);    
		//3.写入 head    
		export.writeHeader(hssfWorkbook, hssfSheet, titleList);    
		//4.写入内容    
		export.writeContent(hssfWorkbook, hssfSheet, 1, headInfoList, dataList);    
		//5.保存文件到filePath中    
//		export.write2FilePath(hssfWorkbook, filePath);    
		export.write2FilePath(hssfWorkbook, fileName, response);    
	} 
    
    public static void exportExcel2FilePath(String sheetName, String filePath, List<String> headInfoList, List<String> titleList, List<Map<String, Object>> dataList) throws IOException { 
    	//List<Map<String, Object>> headInfoList,String filePath
    	ExcelUtils export = new ExcelUtils();     
		//1.创建 Workbook    
		HSSFWorkbook hssfWorkbook = export.getHSSFWorkbook();    
		//2.创建 Sheet    
		HSSFSheet hssfSheet = export.getHSSFSheet(hssfWorkbook, sheetName);    
		//3.写入 head    
		export.writeHeader(hssfWorkbook, hssfSheet, titleList);    
		//4.写入内容    
		export.writeContent(hssfWorkbook, hssfSheet, 1, headInfoList, dataList);    
		//5.保存文件到filePath中    
		export.write2FilePath(hssfWorkbook, filePath);    
		//export.write2FilePath(hssfWorkbook, fileName, response);
	}  
}
