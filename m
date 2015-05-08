From: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
Subject: [PATCH 1/1] i2c: documentation of how to set child bus numbers from
 the device tree
Date: Thu, 07 May 2015 21:57:09 -0700
Message-ID: <554C4225.2030706@rafresearch.com>
References: <1426133507.16219.YahooMailNeo@web181502.mail.ne1.yahoo.com> <20150312094227.GA4225@katana> <20150312112917.GA4888@katana> <5501E52D.9060400@rafresearch.com> <20150314110028.GB970@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150314110028.GB970@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This patch extends the i2cmux description to document how i2c child bus
numbers can be set from the device tree.

Signed-off-by: Bob Feretich <bob.feretich-8wbKi1faPaosQv5ZqcSHkQ@public.gmane.org>
---
--- a/Documentation/devicetree/bindings/i2c/i2c-mux.txt	2015-05-07 
13:27:32.571371080 -0700
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux.txt	2015-05-07 
13:31:58.699044026 -0700
@@ -58,3 +58,78 @@ Example :
  			};
  		};
  	};
+
+The I2C subsystem will assign names to the child busses dynamically in
+the form i2c-n; where 'n' is an incrementing number starting with the
+number following the previously highest allocated bus number.
+
+Aliases may be used to assign static child bus names. The alias name
+must be of the form i2cnn where nn is numeric. The numeric part (nn) is
+used to set the bus number.
+
+Example :
+
+/ {
+	aliases {
+		i2c10 = &im0;
+		i2c11 = &im1;
+		i2c12 = &im2;
+		i2c13 = &im3;
+		i2c14 = &im4;
+		i2c15 = &im5;
+		i2c16 = &im6;
+		i2c17 = &im7;
+	};
+};
+...
+	i2cmux@70 {
+	 	compatible = "nxp,pca9548";
+	 	#address-cells = <1>;
+	 	#size-cells = <0>;
+	 	reg = <0x70>;
+
+ im0:	i2cm@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+ im1:	i2cm@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+ im2:	i2cm@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+ im3:	i2cm@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+ im4:	i2cm@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+ im5:	i2cm@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+ im6:	i2cm@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+ im7:	i2cm@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	 };
+
+The above file segment causes the child i2c busses to be named
+i2c-10 through i2c-17.
+
