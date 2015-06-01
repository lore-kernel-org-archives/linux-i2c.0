From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2 i2c-tools] decode-dimms: New manufacturer names from
 JEP106AQ
Date: Mon, 1 Jun 2015 10:02:50 +0200
Message-ID: <20150601100250.64e1a9b4@endymion.delvare>
References: <20150601095509.747e6074@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150601095509.747e6074-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

---
 eeprom/decode-dimms |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

--- i2c-tools.orig/eeprom/decode-dimms	2015-06-01 09:33:11.965773808 +0200
+++ i2c-tools/eeprom/decode-dimms	2015-06-01 09:47:59.001646064 +0200
@@ -302,7 +302,42 @@ $revision =~ s/ \([^()]*\)//;
  "High Bridge Solutions Industria Eletronica", "Transcend Technology Co. Ltd.",
  "Everspin Technologies", "Hon-Hai Precision", "Smart Storage Systems", "Toumaz Group",
  "Zentel Electronics Corporation", "Panram International Corporation",
- "Silicon Space Technology"]
+ "Silicon Space Technology", "LITE-ON IT Corporation", "Inuitive", "HMicro",
+ "BittWare Inc.", "GLOBALFOUNDRIES", "ACPI Digital Co. Ltd", "Annapurna Labs",
+ "AcSiP Technology Corporation", "Idea! Electronic Systems", "Gowe Technology Co. Ltd",
+ "Hermes Testing Solutions Inc.", "Positivo BGH", "Intelligence Silicon Technology"],
+["3D PLUS", "Diehl Aerospace", "Fairchild", "Mercury Systems",
+ "Sonics Inc.", "GE Intelligent Platforms GmbH & Co.", "Shenzhen Jinge Information Co. Ltd",
+ "SCWW", "Silicon Motion Inc.", "Anurag", "King Kong",
+ "FROM30 Co. Ltd", "Gowin Semiconductor Corp", "Fremont Micro Devices Ltd",
+ "Ericsson Modems", "Exelis", "Satixfy Ltd", "Galaxy Microsystems Ltd",
+ "Gloway International Co. Ltd", "Lab", "Smart Energy Instruments",
+ "Approved Memory Corporation", "Axell Corporation", "ISD Technology Limited",
+ "Phytium", "Xi'an SinoChip Semiconductor", "Ambiq Micro", "eveRAM Technology, Inc.",
+ "Infomax", "Butterfly Network, Inc.", "Shenzhen City Gcai Electronics",
+ "Stack Devices Corporation", "ADK Media Group", "TSP Global Co. Ltd",
+ "HighX", "Shenzhen Elicks Technology", "ISSI/Chingis", "Google Inc.",
+ "Dasima International Development", "Leahkinn Technology Limited",
+ "HIMA Paul Hildebrandt GmbH Co KG", "Keysight Technologies",
+ "Techcomp International (Fastable)", "Ancore Technology Corporation",
+ "Nuvoton", "Korea Uhbele International Group Ltd", "Ikegami Tsushinki Co. Ltd",
+ "RelChip Inc.", "Baikal Electronics", "Nemostech Inc.",
+ "Memorysolution GmbH", "Silicon Integrated Systems Corporation",
+ "Xiede", "Multilaser Components", "Flash Chi", "Jone",
+ "GCT Semiconductor Inc.", "Hong Kong Zetta Device Technology",
+ "Unimemory Technology(s) Pte Ltd", "Cuso", "Kuso",
+ "Uniquify Inc.", "Skymedi Corporation", "Core Chance Co. Ltd",
+ "Tekism Co. Ltd", "Seagate Technology PLC", "Hong Kong Gaia Group Co. Limited",
+ "Gigacom Semiconductor LLC", "V2 Technologies", "TLi", "Neotion",
+ "Lenovo", "Shenzhen Zhongteng Electronic Corp. Ltd", "Compound Photonics",
+ "Cognimem Technologies, Inc.", "Shenzhen Pango Microsystems Co. Ltd",
+ "Vasekey", "Cal-Comp Industria de Semicondutores", "Eyenix Co. Ltd",
+ "Heoriady", "Accelerated Memory Production Inc.", "INVECAS Inc.",
+ "AP Memory", "Douqi Technology", "Etron Technology Inc.",
+ "Indie Semiconductor", "Socionext Inc.", "HGST", "EVGA",
+ "Audience Inc.", "EpicGear", "Vitesse Enterprise Co.",
+ "Foxtronn International Corporation", "Bretelon Inc.",
+ "Zbit Semiconductor Inc."]
 );
 
 $use_sysfs = -d '/sys/bus';

-- 
Jean Delvare
SUSE L3 Support
