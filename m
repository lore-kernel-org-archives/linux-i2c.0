From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: [PATCH v3 5/5] powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board
Date: Tue, 07 Apr 2009 10:20:57 +0200
Message-ID: <20090407082231.803193635@denx.de>
References: <20090407082052.477328750@denx.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline; filename=i2c-mpc-socrates-dts.patch
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Preserve I2C clock settings for the Socrates MPC8544 board.

Signed-off-by: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
---
 arch/powerpc/boot/dts/socrates.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6-galak/arch/powerpc/boot/dts/socrates.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/socrates.dts	2009-04-07 10:09:07.161718915 +0200
+++ linux-2.6-galak/arch/powerpc/boot/dts/socrates.dts	2009-04-07 10:09:16.207719258 +0200
@@ -79,11 +79,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3000 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
-			dfsrr;
+			fsl,preserve-clocking;
 
 			dtt@28 {
 				compatible = "winbond,w83782d";
@@ -111,11 +111,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3100 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
-			dfsrr;
+			fsl,preserve-clocking;
 		};
 
 		enet0: ethernet@24000 {
