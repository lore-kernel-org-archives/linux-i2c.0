From: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Subject: Re: [lm-sensors] I2C support for AMD Hudson-1
Date: Fri, 20 Dec 2013 14:43:49 +0100
Message-ID: <20131220134349.GV25105@phys.ethz.ch>
References: <20131217063226.GD25105@phys.ethz.ch>
 <20131217180131.GB2840@roeck-us.net>
 <20131217181053.GE7071@katana>
Reply-To: Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131217181053.GE7071@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Dear list,

thanks for your instructions. I slightly modified the driver so that it=
 builds
on 3.13-rc4. I can confirm that it works well. I also talked to the com=
pany
(www.men.de) that released the original patch and they would love to ge=
t it
into the kernel. Please find attached the patch to i2c-piix4.c of 3.13-=
rc4.
I also prepared a .tgz that contains
- the original archive from men.de
- my modified driver
- the patch itself

The .tgz can be obtained from http://daduke.org/junk/piix4.tgz

thanks again and Happy Holidays,
-Christian


On Tue, Dec 17, 2013 at 07:10:53PM +0100, Wolfram Sang wrote:
>=20
> > > I'm currently beta testing a pretty cool embedded board for route=
r
> > > applications etc. (http://www.pcengines.ch/apu.htm) that sports a=
 Hudson-1 FCH
> > > which is pretty similar to the Hudson-2 your module supports but =
sufficiently
> > > different so that i2c-piix4 doesn't work.
> > > I found a patched i2c-piix4 source that adds support for the Huds=
on-1 and it
> > > works beautifully: http://www.men.de/products/13SC24-90.html#t=3D=
overview
> > > Now I'm wondering if you would be willing to get this patch into =
lm-sensors
> > > and also the kernel.
> > > If there's anything I can do to help, please let me know.
>=20
> Can't say anything about the patch since it requires registration to =
get
> it :(
>=20
> What you/someone can do:
>=20
> * get the patch
> * port it to a recent kernel and verify it still works
> * read Documentation/SubmittingPatches
> * send the patch
>=20
> Regards,
>=20
>    Wolfram
>=20

#------------------------------------- PATCH ------------#

--- i2c-piix4.c	2013-12-20 14:22:26.000000000 +0100
+++ i2c-piix4.c.orig	2013-12-15 21:31:33.000000000 +0100
@@ -1,40 +1,3 @@
-/*********************  P r o g r a m  -  M o d u l e ****************=
*******/
-/*!
- *        \file  i2c-piix4.c
- *
- *      \author  aw
- *        $Date: 2012/12/03 10:44:30 $
- *    $Revision: 1.1 $
- *
- *        \brief I2C Driver support for SC 24 SMBus. Derived from orig=
inal
- *               i2c-piix4.c and enhanced to support 2nd SMBus control=
ler
- *			     on 08SC24.
- *
- *	       Note: 1st Controller shall be IO-Mapped
- * 				 2nd Controller IO-Mapped or MEM-Mapped
- *
- *     Switches:
- */
-/*---------------------------[ Public Functions ]---------------------=
-------
- *
- *-------------------------------[ History ]--------------------------=
-------
- *
- *  $Log: i2c-piix4.c,v $
- *  Revision 1.1  2012/12/03 10:44:30  awerner
- *  Initial Revision
- *
- *
- *
- *--------------------------------------------------------------------=
-------
- * (c) Copyright 2012 by MEN mikro elektronik GmbH, Nuremberg, Germany
- *
- * This program is free software; you can redistribute  it and/or modi=
fy it
- * under  the terms of  the GNU General Public License as published by=
 the
- * Free Software Foundation; either version 2 of the  License, or (at =
your
- * option) any later version.
- *********************************************************************=
*******/
-
-
 /*
  Copyright (c) 1998 - 2002 Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and
  Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>
@@ -52,18 +15,19 @@
  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
+*/
=20
 /*
  Supports:
  Intel PIIX4, 440MX
  Serverworks OSB4, CSB5, CSB6, HT-1000, HT-1100
- ATI IXP200, IXP300, IXP400, SB600, SB700, SB800
- AMD Hudson-2
+	ATI IXP200, IXP300, IXP400, SB600, SB700/SP5100, SB800
+	AMD Hudson-2, CZ
  SMSC Victory66
=20
- Note: we assume there can only be one device, with one SMBus interfac=
e.
- */
+   Note: we assume there can only be one device, with one or more
+   SMBus interfaces.
+*/
=20
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -73,40 +37,29 @@
 #include <linux/stddef.h>
 #include <linux/ioport.h>
 #include <linux/i2c.h>
+#include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
-#include <linux/mutex.h>
=20
-/*
- *				DEFINES
- */
=20
-/* PIIX4 SMBus adress offset Makros */
-#define SMBHSTSTS	0
-#define SMBHSLVSTS	1
-#define SMBHSTCNT	2
-#define SMBHSTCMD	3
-#define SMBHSTADD	4
-#define SMBHSTDAT0  5
-#define SMBHSTDAT1  6
-#define SMBBLKDAT   7
-#define SMBSLVCNT   8
-#define SMBSHDWCMD  9
-#define SMBSLVEVT   0xA
-#define SMBSLVDAT   0xC
+/* PIIX4 SMBus address offsets */
+#define SMBHSTSTS	(0 + piix4_smba)
+#define SMBHSLVSTS	(1 + piix4_smba)
+#define SMBHSTCNT	(2 + piix4_smba)
+#define SMBHSTCMD	(3 + piix4_smba)
+#define SMBHSTADD	(4 + piix4_smba)
+#define SMBHSTDAT0	(5 + piix4_smba)
+#define SMBHSTDAT1	(6 + piix4_smba)
+#define SMBBLKDAT	(7 + piix4_smba)
+#define SMBSLVCNT	(8 + piix4_smba)
+#define SMBSHDWCMD	(9 + piix4_smba)
+#define SMBSLVEVT	(0xA + piix4_smba)
+#define SMBSLVDAT	(0xC + piix4_smba)
=20
 /* count for request_region */
-#define SMBIOSIZE	8	/* IO-mapped 1st SMBus */
-#define SMBMSIZE    8	/* Memory-mapped 2nd SMBus */
-
-#define ACPIMMIOEN_ENBL 0x00000001
-#define ACPIMMIOEN_SEL	0x00000002
-
-/* Mapping of SMBus 1 Controller */
-#define MEMMAP		0
-#define IOMAP		1
+#define SMBIOSIZE	8
=20
 /* PCI Address Constants */
 #define SMBBA		0x090
@@ -116,9 +69,6 @@
 #define SMBSHDW2	0x0D5
 #define SMBREV		0x0D6
=20
-/* primary controller IO mapped addresses */
-#define SMB_ADDR_INDEX	0xcd6
-
 /* Other settings */
 #define MAX_TIMEOUT	500
 #define  ENABLE_INT9	0
@@ -146,70 +96,10 @@ MODULE_PARM_DESC(force_addr,
 		"Forcibly enable the PIIX4 at the given address. "
 		"EXTREMELY DANGEROUS!");
=20
-
-/*
- *				GLOBALES                    =20
- */
-
-/* SMBus base adress Controller 0 */
-static unsigned short piix4_smba0;
-/* SMBus base adress Controller 1 */
-static unsigned int piix4_smba1;
-
 static int srvrworks_csb5_delay;
 static struct pci_driver piix4_driver;
=20
-static struct i2c_adapter piix4_adapter0;
-static struct i2c_adapter piix4_adapter1;
-static struct i2c_adapter piix4_adapter2;
-
-static u8 SMBusMap;
-
-/* virtual adress 2nd SMBus Controller */
-static void *virt_addr;
-
-
-/* mutex to lock the transaction functions,
- * because it could be that both Controller/adapter access=20
- * the function at the same time.*/
-static struct mutex funcLock;
-
-/*********************************************************************=
***/
-/** request IO or mem mapped memory
- *				=09
- *  \param  from 		\IN start address to release
- *	\param  length		\IN length of data to release
- *	\param  spacetype	\IN 0 =3D memory  1 =3D IO. Type of requested mem=
ory
- *
- *  \return				\c 0 On success or error code
- */
-struct resource *reqAdressSpace(unsigned long from, unsigned long leng=
th,
-		const char* name, u8 spacetype) {
-	if (spacetype =3D=3D MEMMAP)
-		return request_mem_region(from, length, name);
-
-	else
-		return request_region(from, length, name);
-}
-
-
-/*********************************************************************=
***/
-/** free requested memory, IO or mem mapped
- *				=09
- *  \param  from 		\IN start address to release
- *	\param  length		\IN length of data to release
- *	\param  spacetype	\IN 0 =3D memory  1 =3D IO. Type of requested mem=
ory
- *
- *  \return				\c 0 On success or error code
- */
-void relAdressSpace(unsigned long from, unsigned long length, u8 space=
type) {
-	if (spacetype =3D=3D MEMMAP)
-		release_mem_region(from, length);
-	else
-		release_region(from, length);
-}
-
-static struct dmi_system_id piix4_dmi_blacklist[] =3D {
+static const struct dmi_system_id piix4_dmi_blacklist[] =3D {
 	{
 		.ident =3D "Sapphire AM2RD790",
 		.matches =3D {
@@ -224,32 +114,28 @@ static struct dmi_system_id piix4_dmi_bl
 			DMI_MATCH(DMI_BOARD_NAME, "LP UT 790FX"),
 		},
 	},
-	{}
+	{ }
 };
=20
 /* The IBM entry is in a separate table because we only check it
  on Intel-based systems */
-static struct dmi_system_id  piix4_dmi_ibm[] =3D {
+static const struct dmi_system_id piix4_dmi_ibm[] =3D {
 	{
 		.ident =3D "IBM",
-		.matches =3D {DMI_MATCH(DMI_SYS_VENDOR, "IBM"),},
+		.matches =3D { DMI_MATCH(DMI_SYS_VENDOR, "IBM"), },
 	},
-	{},
+	{ },
 };
=20
+struct i2c_piix4_adapdata {
+	unsigned short smba;
+};
=20
-/*********************************************************************=
***/
-/** SMB controller setup function called upon module init
- *				=09
- *  \param  *PIIX4_dev 	\IN PCI device struct
- *	\param  *id			\IN PCI device ID
- *
- *  \return				\c 0 On success or error code
- */
 static int piix4_setup(struct pci_dev *PIIX4_dev,
 		const struct pci_device_id *id)
 {
 	unsigned char temp;
+	unsigned short piix4_smba;
=20
 	if ((PIIX4_dev->vendor =3D=3D PCI_VENDOR_ID_SERVERWORKS) &&
 			(PIIX4_dev->device =3D=3D PCI_DEVICE_ID_SERVERWORKS_CSB5))
@@ -274,12 +160,12 @@ static int piix4_setup(struct pci_dev *P
=20
 	/* Determine the address of the SMBus areas */
 	if (force_addr) {
-		piix4_smba0 =3D force_addr & 0xfff0;
+		piix4_smba =3D force_addr & 0xfff0;
 		force =3D 0;
 	} else {
-		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba0);
-		piix4_smba0 &=3D 0xfff0;
-		if(piix4_smba0 =3D=3D 0) {
+		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
+		piix4_smba &=3D 0xfff0;
+		if(piix4_smba =3D=3D 0) {
 			dev_err(&PIIX4_dev->dev, "SMBus base address "
 					"uninitialized - upgrade BIOS or use "
 					"force_addr=3D0xaddr\n");
@@ -287,12 +173,12 @@ static int piix4_setup(struct pci_dev *P
 		}
 	}
=20
-	if (acpi_check_region(piix4_smba0, SMBIOSIZE, piix4_driver.name))
+	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
 	return -ENODEV;
=20
-	if (!request_region(piix4_smba0, SMBIOSIZE, piix4_driver.name)) {
+	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
 		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
-				piix4_smba0);
+			piix4_smba);
 		return -EBUSY;
 	}
=20
@@ -302,10 +188,10 @@ static int piix4_setup(struct pci_dev *P
 	 sure, we disable the PIIX4 first. */
 	if (force_addr) {
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
-		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba0);
+		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp | 0x01);
 		dev_info(&PIIX4_dev->dev, "WARNING: SMBus interface set to "
-				"new address %04x!\n", piix4_smba0);
+			"new address %04x!\n", piix4_smba);
 	} else if ((temp & 1) =3D=3D 0) {
 		if (force) {
 			/* This should never need to be done, but has been
@@ -318,14 +204,12 @@ static int piix4_setup(struct pci_dev *P
 			 */
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
 					temp | 1);
-			dev_printk(KERN_NOTICE, &PIIX4_dev->dev,
-					"WARNING: SMBus interface has been "
-					"FORCEFULLY ENABLED!\n");
+			dev_notice(&PIIX4_dev->dev,
+				   "WARNING: SMBus interface has been FORCEFULLY ENABLED!\n");
 		} else {
 			dev_err(&PIIX4_dev->dev,
 					"Host SMBus controller not enabled!\n");
-			release_region(piix4_smba0, SMBIOSIZE);
-			piix4_smba0 =3D 0;
+			release_region(piix4_smba, SMBIOSIZE);
 			return -ENODEV;
 		}
 	}
@@ -341,30 +225,17 @@ static int piix4_setup(struct pci_dev *P
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
 	dev_info(&PIIX4_dev->dev,
 			"SMBus Host Controller at 0x%x, revision %d\n",
-			piix4_smba0, temp);
+		 piix4_smba, temp);
=20
-	return 0;
+	return piix4_smba;
 }
=20
-/*********************************************************************=
***/
-/** setup primary sb800 SMB controller
- *
- * This Function determine the base adress of the 2nd Controller [SMBu=
s 1].=20
- * There is also a query if the controller is enabled, and a query if	=
=09
- * if the Controller is IO or Memory mapped.							=09
- * If the controller is memory mapped, the function will get a virtuel=
l	   =20
- * adress to work with.													=09
- *
- *  \param *PIIX4_dev	\IN i2c pci main device Handle
- *  \param *id			\IN i2c pci main device ID=09
- *
- *  \return         \c 0 On success or error code
- */
 static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
-		const struct pci_device_id *id)
+			     const struct pci_device_id *id, u8 aux)
 {
-	unsigned short smba_idx =3D SMB_ADDR_INDEX;
-	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset =3D 0x10, smb_en =3D=
 0x2c;
+	unsigned short piix4_smba;
+	unsigned short smba_idx =3D 0xcd6;
+	u8 smba_en_lo, smba_en_hi, i2ccfg, i2ccfg_offset =3D 0x10, smb_en;
=20
 	/* SB800 and later SMBus does not support forcing address */
 	if (force || force_addr) {
@@ -374,6 +245,8 @@ static int piix4_setup_sb800(struct pci_
 	}
=20
 	/* Determine the address of the SMBus areas */
+	smb_en =3D (aux) ? 0x28 : 0x2c;
+
 	if (!request_region(smba_idx, 2, "smba_idx")) {
 		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
 				"0x%x already in use!\n", smba_idx);
@@ -385,34 +258,38 @@ static int piix4_setup_sb800(struct pci_
 	smba_en_hi =3D inb_p(smba_idx + 1);
 	release_region(smba_idx, 2);
=20
-	/* check if the SMBus is enabled */
 	if ((smba_en_lo & 1) =3D=3D 0) {
 		dev_err(&PIIX4_dev->dev,
 				"Host SMBus controller not enabled!\n");
 		return -ENODEV;
 	}
=20
-	piix4_smba0 =3D ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
-	if (acpi_check_region(piix4_smba0, SMBIOSIZE, piix4_driver.name))
+	piix4_smba =3D ((smba_en_hi << 8) | smba_en_lo) & 0xffe0;
+	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
 	return -ENODEV;
=20
-	if (!request_region(piix4_smba0, SMBIOSIZE, piix4_driver.name)) {
+	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
 		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
-				piix4_smba0);
+			piix4_smba);
 		return -EBUSY;
 	}
=20
+	/* Aux SMBus does not support IRQ information */
+	if (aux) {
+		dev_info(&PIIX4_dev->dev,
+			 "SMBus Host Controller at 0x%x\n", piix4_smba);
+		return piix4_smba;
+	}
+
 	/* Request the SMBus I2C bus config region */
-	if (!request_region(piix4_smba0 + i2ccfg_offset, 1, "i2ccfg")) {
+	if (!request_region(piix4_smba + i2ccfg_offset, 1, "i2ccfg")) {
 		dev_err(&PIIX4_dev->dev, "SMBus I2C bus config region "
-				"0x%x already in use!\n", piix4_smba0 + i2ccfg_offset);
-		release_region(piix4_smba0, SMBIOSIZE);
-		piix4_smba0 =3D 0;
+			"0x%x already in use!\n", piix4_smba + i2ccfg_offset);
+		release_region(piix4_smba, SMBIOSIZE);
 		return -EBUSY;
 	}
-
-	i2ccfg =3D inb_p(piix4_smba0 + i2ccfg_offset);
-	release_region(piix4_smba0 + i2ccfg_offset, 1);
+	i2ccfg =3D inb_p(piix4_smba + i2ccfg_offset);
+	release_region(piix4_smba + i2ccfg_offset, 1);
=20
 	if (i2ccfg & 1)
 	dev_dbg(&PIIX4_dev->dev, "Using IRQ for SMBus.\n");
@@ -421,117 +298,70 @@ static int piix4_setup_sb800(struct pci_
=20
 	dev_info(&PIIX4_dev->dev,
 			"SMBus Host Controller at 0x%x, revision %d\n",
-			piix4_smba0, i2ccfg >> 4);
+		 piix4_smba, i2ccfg >> 4);
=20
-	return 0;
+	return piix4_smba;
 }
=20
-
-/*********************************************************************=
***/
-/** setup secondary sb800 SMB controller
- *
- * This Function determine the base adress of the 2nd Controller [SMBu=
s 1].=20
- * There is also a query if the controller is enabled, and a query if	=
=09
- * if the Controller is IO or Memory mapped.							=09
- * If the controller is memory mapped, the function will get a virtuel=
l	   =20
- * adress to work with.													=09
- *
- *  \param *PIIX4_dev	\IN i2c pci main device Handle =20
- *  \param *id			\IN i2c pci main device ID=09
- *
- *  \return         \c 0 On success or error code
- */
-static int sec_piix4_setup_sb800(struct pci_dev *PIIX4_dev,
-		const struct pci_device_id *id)
+static int piix4_setup_aux(struct pci_dev *PIIX4_dev,
+			   const struct pci_device_id *id,
+			   unsigned short base_reg_addr)
 {
-	unsigned short smba_idx =3D SMB_ADDR_INDEX;
-	unsigned int i;
-	u8 smb_en =3D 0x24;
+	/* Set up auxiliary SMBus controllers found on some
+	 * AMD chipsets e.g. SP5100 (SB700 derivative) */
=20
-	/* SB800 and later SMBus does not support forcing address */
-	if (force || force_addr) {
-		dev_err(&PIIX4_dev->dev, "SMBus does not support "
-				"forcing address!\n");
-		return -EINVAL;
-	}
-
-	/* Determine the address of the 2nd SMBus Controller */
-	if (!request_region(smba_idx, 4, "smba_idx")) {
-		dev_err(&PIIX4_dev->dev, "SMBus base address index region "
-				"0x%x already in use!\n", smba_idx);
-		return -EBUSY;
-	}
+	unsigned short piix4_smba;
=20
-	/* retrieve mem mapped address of 2nd controller */
-	for (i=3D0; i<4; i++) {
-		/* write indirect index of Address...*/
-		outb_p(smb_en+i, smba_idx);
-		/* and read address bytes, 4 times */
-		piix4_smba1 |=3D(inb_p(smba_idx+1)) << (i*8);
+	/* Read address of auxiliary SMBus controller */
+	pci_read_config_word(PIIX4_dev, base_reg_addr, &piix4_smba);
+	if ((piix4_smba & 1) =3D=3D 0) {
+		dev_dbg(&PIIX4_dev->dev,
+			"Auxiliary SMBus controller not enabled\n");
+		return -ENODEV;
 	}
=20
-	release_region(smba_idx, 4);
-
-	/* check if 2nd controller is ENABLED */
-	if( !(piix4_smba1 & ACPIMMIOEN_ENBL) ) {
-		dev_err(&PIIX4_dev->dev,
-				"Host SMBus1 2nd controller not enabled!\n");
+	piix4_smba &=3D 0xfff0;
+	if (piix4_smba =3D=3D 0) {
+		dev_dbg(&PIIX4_dev->dev,
+			"Auxiliary SMBus base address uninitialized\n");
 		return -ENODEV;
 	}
=20
-	/* Check if the 2nd Controller is MEM-mapped or IO-mapped        				=
		    */
-	/* New Functions to Request and Release Space Areas "reqAdressSpace()=
 and relAdressSpace()" */
-	/* to differ between request_mem_region and request_region        			=
			    */
-	if( piix4_smba1 & ACPIMMIOEN_SEL )
-	SMBusMap =3D IOMAP;
-	else
-	SMBusMap =3D MEMMAP;
-
-	/* adress mask + 0x900 Offset for the ASF-Registers */
-	piix4_smba1 =3D ( piix4_smba1 & 0xFFFFF000 ) + 0x900;
+	if (acpi_check_region(piix4_smba, SMBIOSIZE, piix4_driver.name))
+		return -ENODEV;
=20
-	/* Request space region of 2nd Controller SMBus 1 */
-	if ( !reqAdressSpace(piix4_smba1, SMBMSIZE, "piix4_I2C_2nd_Controller=
",SMBusMap) ) {
-		dev_err(&PIIX4_dev->dev, "SMBus region 0x%x already in use!\n",
-				piix4_smba1);
+	if (!request_region(piix4_smba, SMBIOSIZE, piix4_driver.name)) {
+		dev_err(&PIIX4_dev->dev, "Auxiliary SMBus region 0x%x "
+			"already in use!\n", piix4_smba);
 		return -EBUSY;
 	}
=20
-	/* printk("MEN: Address of 2nd I2C controller =3D 0x%08x\n", piix4_sm=
ba1); */
-
-	/* memory mapping 2nd SMBus Controller */
-	if(SMBusMap =3D=3D MEMMAP)
-		virt_addr =3D ioremap(piix4_smba1,SMBMSIZE);
+	dev_info(&PIIX4_dev->dev,
+		 "Auxiliary SMBus Host Controller at 0x%x\n",
+		 piix4_smba);
=20
-	return 0;
+	return piix4_smba;
 }
=20
-
-/*********************************************************************=
***/
-/** Transaction function for both Controllers, IO-mapped
- *				=09
- *  \param SMBusaddr    \IN adress of SMBus Controller
- *  \param i2c_adapter  \IN adapter which comes from the i2c_access fu=
nction
- *
- *  \return				\c 0 On success or error code
- */
-
-static int piix4_transaction_io(unsigned int SMBusddr,struct i2c_adapt=
er *piix4_adapter)=20
+static int piix4_transaction(struct i2c_adapter *piix4_adapter)
 {
+	struct i2c_piix4_adapdata *adapdata =3D i2c_get_adapdata(piix4_adapte=
r);
+	unsigned short piix4_smba =3D adapdata->smba;
 	int temp;
 	int result =3D 0;
 	int timeout =3D 0;
=20
 	dev_dbg(&piix4_adapter->dev, "Transaction (pre): CNT=3D%02x, CMD=3D%0=
2x, "
-			"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", inb_p(SMBusddr + SMBHSTCN=
T),
-			inb_p(SMBusddr + SMBHSTCMD), inb_p(SMBusddr + SMBHSTADD),
-			inb_p(SMBusddr + SMBHSTDAT0), inb_p(SMBusddr + SMBHSTDAT1));
+		"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
=20
 	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp =3D inb_p(SMBusddr + SMBHSTSTS)) !=3D 0x00) {
-		dev_dbg(&piix4_adapter->dev, "SMBus busy (%02x). Resetting...\n", te=
mp);
-		outb_p(temp, SMBusddr + SMBHSTSTS);
-		if ((temp =3D inb_p(SMBusddr + SMBHSTSTS)) !=3D 0x00) {
+	if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0x00) {
+		dev_dbg(&piix4_adapter->dev, "SMBus busy (%02x). "
+			"Resetting...\n", temp);
+		outb_p(temp, SMBHSTSTS);
+		if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0x00) {
 			dev_err(&piix4_adapter->dev, "Failed! (%02x)\n", temp);
 			return -EBUSY;
 		} else {
@@ -540,7 +370,7 @@ static int piix4_transaction_io(unsigned
 	}
=20
 	/* start the transaction by setting bit 6 */
-	outb_p(inb(SMBusddr + SMBHSTCNT) | 0x040, SMBusddr + SMBHSTCNT);
+	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
=20
 	/* We will always wait for a fraction of a second! (See PIIX4 docs er=
rata) */
 	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
@@ -548,8 +378,8 @@ static int piix4_transaction_io(unsigned
 	else
 		msleep(1);
=20
-	while ((++timeout < MAX_TIMEOUT)
-			&& ((temp =3D inb_p(SMBusddr + SMBHSTSTS)) & 0x01))
+	while ((++timeout < MAX_TIMEOUT) &&
+	       ((temp =3D inb_p(SMBHSTSTS)) & 0x01))
 		msleep(1);
=20
 	/* If the SMBus is still busy, we give up */
@@ -575,187 +405,73 @@ static int piix4_transaction_io(unsigned
 		dev_dbg(&piix4_adapter->dev, "Error: no response!\n");
 	}
=20
-	if (inb_p(SMBusddr+ SMBHSTSTS) !=3D 0x00)
-		outb_p(inb(SMBusddr + SMBHSTSTS), SMBusddr + SMBHSTSTS);
+	if (inb_p(SMBHSTSTS) !=3D 0x00)
+		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
=20
-	if ((temp =3D inb_p(SMBusddr + SMBHSTSTS)) !=3D 0x00) {
+	if ((temp =3D inb_p(SMBHSTSTS)) !=3D 0x00) {
 		dev_err(&piix4_adapter->dev, "Failed reset at end of "
 				"transaction (%02x)\n", temp);
 	}
 	dev_dbg(&piix4_adapter->dev, "Transaction (post): CNT=3D%02x, CMD=3D%=
02x, "
-			"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", inb_p(SMBusddr + SMBHSTCN=
T),
-			inb_p(SMBusddr + SMBHSTCMD), inb_p(SMBusddr + SMBHSTADD),
-			inb_p(SMBusddr + SMBHSTDAT0), inb_p(SMBusddr + SMBHSTDAT1));
+		"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 	return result;
 }
=20
-
-
-/*********************************************************************=
***/
-/** Transaction function for primary Controller, IO-mapped
- *				=09
- * This function access the 1st Controller [SMBus 0] via the i2c_adapt=
er =09
- * if the Controller is IO-mapped										   =20
- * and call the transaction function to transmit or receive data	     =
  =20
- *
- *  \param  *adap	 	\IN i2c adapter				      			=09
- *	\param  addr	    \IN adress of a Controller Register		=09
- *  \param  flags		\IN unused										=09
- *	\param  read_write	\IN read or write operation						=09
- *  \param	command		\IN ommand to send								=09
- *	\param	size														=09
- *	\param  *data		data to send	=09
- *
- *  \return				\c 0 On success or error code
- */
-static s32 piix4_access_io(struct i2c_adapter * adap, u16 addr,
-		unsigned short flags, char read_write, u8 command, int size,
-		union i2c_smbus_data * data) {
-	int i, len;
-	int status;
-
-	switch (size) {
-	case I2C_SMBUS_QUICK:
-		outb_p((addr << 1) * read_write, piix4_smba0 + SMBHSTADD);
-		size =3D PIIX4_QUICK;
-		break;
-	case I2C_SMBUS_BYTE:
-		outb_p((addr << 1) * read_write, piix4_smba0 + SMBHSTADD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(command, piix4_smba0 + SMBHSTCMD);
-		size =3D PIIX4_BYTE;
-		break;
-	case I2C_SMBUS_BYTE_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba0 + SMBHSTADD);
-		outb_p(command, piix4_smba0 + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(data->byte, piix4_smba0 + SMBHSTDAT0);
-		size =3D PIIX4_BYTE_DATA;
-		break;
-	case I2C_SMBUS_WORD_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba0 + SMBHSTADD);
-		outb_p(command, piix4_smba0 + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			outb_p(data->word & 0xff, piix4_smba0 + SMBHSTDAT0);
-			outb_p((data->word & 0xff00) >> 8, piix4_smba0 + SMBHSTDAT1);
-		}
-		size =3D PIIX4_WORD_DATA;
-		break;
-	case I2C_SMBUS_BLOCK_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba0 + SMBHSTADD);
-		outb_p(command, piix4_smba0 + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			len =3D data->block[0];
-			if (len =3D=3D 0 || len > I2C_SMBUS_BLOCK_MAX)
-				return -EINVAL;
-			outb_p(len, piix4_smba0 + SMBHSTDAT0);
-			i =3D inb_p(piix4_smba0 + SMBHSTCNT); /* Reset SMBBLKDAT */
-			for (i =3D 1; i <=3D len; i++)
-				outb_p(data->block[i], piix4_smba0 + SMBBLKDAT);
-		}
-		size =3D PIIX4_BLOCK_DATA;
-		break;
-	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
-		return -EOPNOTSUPP;
-	}
-
-	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), piix4_smba0 + SMBHSTCNT);
-
-	mutex_lock(&funcLock);
-
-	status =3D piix4_transaction_io(piix4_smba0, adap);
-
-	mutex_unlock(&funcLock);
-
-	if (status)
-		return status;
-
-	if ((read_write =3D=3D I2C_SMBUS_WRITE) || (size =3D=3D PIIX4_QUICK))
-		return 0;
-
-	switch (size) {
-	case PIIX4_BYTE:
-	case PIIX4_BYTE_DATA:
-		data->byte =3D inb_p(piix4_smba0 + SMBHSTDAT0);
-		break;
-	case PIIX4_WORD_DATA:
-		data->word =3D inb_p(piix4_smba0 + SMBHSTDAT0)
-				+ (inb_p(piix4_smba0 + SMBHSTDAT1) << 8);
-		break;
-	case PIIX4_BLOCK_DATA:
-		data->block[0] =3D inb_p(piix4_smba0 + SMBHSTDAT0);
-		if (data->block[0] =3D=3D 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
-			return -EPROTO;
-		i =3D inb_p(piix4_smba0 + SMBHSTCNT); /* Reset SMBBLKDAT */
-		for (i =3D 1; i <=3D data->block[0]; i++)
-			data->block[i] =3D inb_p(piix4_smba0 + SMBBLKDAT);
-		break;
-	}
-	return 0;
-
-}
-
-/*********************************************************************=
***/
-/** Transaction function for secondary Controller, IO-mapped
- *				=09
- * This function access the 2nd Controller [SMBus 1] via the i2c_adapt=
er
- * if the Controller is IO-mapped,									=09
- * and call the transaction function to transmit or receive data	     =
 =20
- *  \param  *adap	 	\IN i2c adapter				      			=09
- *	\param  addr	    \IN adress of a Controller Register		=09
- *  \param  flags		\IN unused										=09
- *	\param  read_write	\IN read or write operation						=09
- *  \param	command		\IN ommand to send								=09
- *	\param	size														=09
- *	\param  *data		data to send	=09
- *
- *  \return				\c 0 On success or error code
- */
-static s32 sec_piix4_access_io(struct i2c_adapter * adap, u16 addr,
-		unsigned short flags, char read_write, u8 command, int size,
-		union i2c_smbus_data * data) {
+/* Return negative errno on error. */
+static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+		 unsigned short flags, char read_write,
+		 u8 command, int size, union i2c_smbus_data * data)
+{
+	struct i2c_piix4_adapdata *adapdata =3D i2c_get_adapdata(adap);
+	unsigned short piix4_smba =3D adapdata->smba;
 	int i, len;
 	int status;
=20
 	switch (size) {
 	case I2C_SMBUS_QUICK:
-		outb_p((addr << 1) | read_write, piix4_smba1 + SMBHSTADD);
+		outb_p((addr << 1) | read_write,
+		       SMBHSTADD);
 		size =3D PIIX4_QUICK;
 		break;
 	case I2C_SMBUS_BYTE:
-		outb_p((addr << 1) | read_write, piix4_smba1 + SMBHSTADD);
+		outb_p((addr << 1) | read_write,
+		       SMBHSTADD);
 		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(command, piix4_smba1 + SMBHSTCMD);
+			outb_p(command, SMBHSTCMD);
 		size =3D PIIX4_BYTE;
 		break;
 	case I2C_SMBUS_BYTE_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba1 + SMBHSTADD);
-		outb_p(command, piix4_smba1 + SMBHSTCMD);
+		outb_p((addr << 1) | read_write,
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
 		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			outb_p(data->byte, piix4_smba1 + SMBHSTDAT0);
+			outb_p(data->byte, SMBHSTDAT0);
 		size =3D PIIX4_BYTE_DATA;
 		break;
 	case I2C_SMBUS_WORD_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba1 + SMBHSTADD);
-		outb_p(command, piix4_smba1 + SMBHSTCMD);
+		outb_p((addr << 1) | read_write,
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
 		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			outb_p(data->word & 0xff, piix4_smba1 + SMBHSTDAT0);
-			outb_p((data->word & 0xff00) >> 8, piix4_smba1 + SMBHSTDAT1);
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
 		}
 		size =3D PIIX4_WORD_DATA;
 		break;
 	case I2C_SMBUS_BLOCK_DATA:
-		outb_p((addr << 1) | read_write, piix4_smba1 + SMBHSTADD);
-		outb_p(command, piix4_smba1 + SMBHSTCMD);
+		outb_p((addr << 1) | read_write,
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
 		if (read_write =3D=3D I2C_SMBUS_WRITE) {
 			len =3D data->block[0];
 			if (len =3D=3D 0 || len > I2C_SMBUS_BLOCK_MAX)
 				return -EINVAL;
-			outb_p(len, piix4_smba1 + SMBHSTDAT0);
-			i =3D inb_p(piix4_smba1 + SMBHSTCNT); /* Reset SMBBLKDAT */
+			outb_p(len, SMBHSTDAT0);
+			i =3D inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 			for (i =3D 1; i <=3D len; i++)
-				outb_p(data->block[i], piix4_smba1 + SMBBLKDAT);
+				outb_p(data->block[i], SMBBLKDAT);
 		}
 		size =3D PIIX4_BLOCK_DATA;
 		break;
@@ -764,281 +480,49 @@ static s32 sec_piix4_access_io(struct i2
 		return -EOPNOTSUPP;
 	}
=20
-	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), piix4_smba1 + SMBHSTCNT);
-
-	mutex_lock(&funcLock);
-
-	status =3D piix4_transaction_io(piix4_smba1,adap);
-
-	mutex_unlock(&funcLock);
+	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
=20
+	status =3D piix4_transaction(adap);
 	if (status)
 		return status;
=20
 	if ((read_write =3D=3D I2C_SMBUS_WRITE) || (size =3D=3D PIIX4_QUICK))
 		return 0;
=20
-	switch (size) {
-	case PIIX4_BYTE:
-	case PIIX4_BYTE_DATA:
-		data->byte =3D inb_p(piix4_smba1 + SMBHSTDAT0);
-		break;
-	case PIIX4_WORD_DATA:
-		data->word =3D inb_p(piix4_smba1 + SMBHSTDAT0)
-				+ (inb_p(piix4_smba1 + SMBHSTDAT1) << 8);
-		break;
-	case PIIX4_BLOCK_DATA:
-		data->block[0] =3D inb_p(piix4_smba1 + SMBHSTDAT0);
-		if (data->block[0] =3D=3D 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
-			return -EPROTO;
-		i =3D inb_p(piix4_smba1 + SMBHSTCNT); /* Reset SMBBLKDAT */
-		for (i =3D 1; i <=3D data->block[0]; i++)
-			data->block[i] =3D inb_p(piix4_smba1 + SMBBLKDAT);
-		break;
-	}
-	return 0;
-
-}
-
-
-/*********************************************************************=
***/
-/** separate transaction function for secondary Controller, mem-mapped
- *				=09
- *  \return				\c 0 On success or error code
- */
-
-static int piix4_transaction_mem(void) {
-	int temp;
-	int result =3D 0;
-	int timeout =3D 0;
-
-	dev_dbg(&piix4_adapter1.dev, "Transaction (pre): CNT=3D%02x, CMD=3D%0=
2x, "
-			"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", readb(virt_addr + SMBHSTC=
NT),
-			readb(virt_addr + SMBHSTCMD), readb(virt_addr + SMBHSTADD),
-			readb(virt_addr + SMBHSTDAT0), readb(virt_addr + SMBHSTDAT1));
-
-	/* Make sure the SMBus host is ready to start transmitting */
-	if ((temp =3D readb(virt_addr + SMBHSTSTS)) !=3D 0x00) {
-		dev_dbg(&piix4_adapter1.dev, "SMBus busy (%02x). "
-				"Resetting...\n", temp);
-		writeb(temp, virt_addr + SMBHSTSTS);
-		if ((temp =3D readb(virt_addr + SMBHSTSTS)) !=3D 0x00) {
-			dev_err(&piix4_adapter1.dev, "Failed! (%02x)\n", temp);
-			return -EBUSY;
-		} else {
-			dev_dbg(&piix4_adapter1.dev, "Successful!\n");
-		}
-	}
-
-	/* start the transaction by setting bit 6 */
-	writeb(readb(virt_addr + SMBHSTCNT) | 0x040, virt_addr + SMBHSTCNT);
-
-	/* We will always wait for a fraction of a second! (See PIIX4 docs er=
rata) */
-	if (srvrworks_csb5_delay) /* Extra delay for SERVERWORKS_CSB5 */
-		msleep(2);
-	else
-		msleep(1);
-
-	while ((++timeout < MAX_TIMEOUT)
-			&& ((temp =3D readb(virt_addr + SMBHSTSTS)) & 0x01))
-		msleep(1);
-
-	/* If the SMBus is still busy, we give up */
-	if (timeout =3D=3D MAX_TIMEOUT) {
-		dev_err(&piix4_adapter1.dev, "SMBus Timeout!\n");
-		result =3D -ETIMEDOUT;
-	}
-
-	if (temp & 0x10) {
-		result =3D -EIO;
-		dev_err(&piix4_adapter1.dev, "Error: Failed bus transaction\n");
-	}
-
-	if (temp & 0x08) {
-		result =3D -EIO;
-		dev_dbg(&piix4_adapter1.dev, "Bus collision! SMBus may be "
-				"locked until next hard reset. (sorry!)\n");
-		/* Clock stops and slave is stuck in mid-transmission */
-	}
-
-	if (temp & 0x04) {
-		result =3D -ENXIO;
-		dev_dbg(&piix4_adapter1.dev, "Error: no response!\n");
-	}
-
-	if (readb(virt_addr + SMBHSTSTS) !=3D 0x00)
-		writeb(readb(virt_addr + SMBHSTSTS), virt_addr + SMBHSTSTS);
-
-	if ((temp =3D readb(virt_addr + SMBHSTSTS)) !=3D 0x00) {
-		dev_err(&piix4_adapter1.dev, "Failed reset at end of "
-				"transaction (%02x)\n", temp);
-	}
-	dev_dbg(&piix4_adapter1.dev, "Transaction (post): CNT=3D%02x, CMD=3D%=
02x, "
-			"ADD=3D%02x, DAT0=3D%02x, DAT1=3D%02x\n", readb(virt_addr + SMBHSTC=
NT),
-			readb(virt_addr + SMBHSTCMD), readb(virt_addr + SMBHSTADD),
-			readb(virt_addr + SMBHSTDAT0), readb(virt_addr + SMBHSTDAT1));
-
-	return result;
-}
-
-
-/*********************************************************************=
***/
-/** Transaction function for both Controllers, mem-mapped
- *				=09
- * This function accesses the given Controller via the i2c_adapter =09
- * if the Controller is IO-mapped										   =20
- * and call the transaction function to transmit or receive data	     =
  =20
- *
- *  \param  *adap	 	\IN i2c adapter				      			=09
- *	\param  addr	    \IN adress of a Controller Register		=09
- *  \param  flags		\IN unused										=09
- *	\param  read_write	\IN read or write operation						=09
- *  \param	command		\IN ommand to send								=09
- *	\param	size														=09
- *	\param  *data		data to send	=09
- *
- *  \return				\c 0 On success or error code
- */
-
-static s32 piix4_access_mem(struct i2c_adapter * adap, u16 addr,
-		unsigned short flags, char read_write, u8 command, int size,
-		union i2c_smbus_data * data) {
-	int i, len;
-	int status;
-
-	switch (size) {
-	case I2C_SMBUS_QUICK:
-		writeb((addr << 1) | read_write, virt_addr + SMBHSTADD);
-		size =3D PIIX4_QUICK;
-		break;
-	case I2C_SMBUS_BYTE:
-		writeb((addr << 1) | read_write, virt_addr + SMBHSTADD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			writeb(command, virt_addr + SMBHSTCMD);
-		size =3D PIIX4_BYTE;
-		break;
-	case I2C_SMBUS_BYTE_DATA:
-		writeb((addr << 1) | read_write, virt_addr + SMBHSTADD);
-		writeb(command, virt_addr + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE)
-			writeb(data->byte, virt_addr + SMBHSTDAT0);
-		size =3D PIIX4_BYTE_DATA;
-		break;
-	case I2C_SMBUS_WORD_DATA:
-		writeb((addr << 1) | read_write, virt_addr + SMBHSTADD);
-		writeb(command, virt_addr + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			writeb(data->word & 0xff, virt_addr + SMBHSTDAT0);
-			writeb((data->word & 0xff00) >> 8, virt_addr + SMBHSTDAT1);
-		}
-		size =3D PIIX4_WORD_DATA;
-		break;
-	case I2C_SMBUS_BLOCK_DATA:
-		writeb((addr << 1) | read_write, virt_addr + SMBHSTADD);
-		writeb(command, virt_addr + SMBHSTCMD);
-		if (read_write =3D=3D I2C_SMBUS_WRITE) {
-			len =3D data->block[0];
-			if (len =3D=3D 0 || len > I2C_SMBUS_BLOCK_MAX)
-				return -EINVAL;
-			writeb(len, virt_addr + SMBHSTDAT0);
-			i =3D readb(virt_addr + SMBHSTCNT); /* Reset SMBBLKDAT */
-			for (i =3D 1; i <=3D len; i++)
-				writeb(data->block[i], virt_addr + SMBBLKDAT);
-		}
-		size =3D PIIX4_BLOCK_DATA;
-		break;
-	default:
-		dev_warn(&adap->dev, "Unsupported transaction %d\n", size);
-		return -EOPNOTSUPP;
-	}
-
-	writeb((size & 0x1C) + (ENABLE_INT9 & 1), virt_addr + SMBHSTCNT);
-
-	status =3D piix4_transaction_mem();
-	if (status)
-		return status;
-
-	if ((read_write =3D=3D I2C_SMBUS_WRITE) || (size =3D=3D PIIX4_QUICK))
-		return 0;
=20
 	switch (size) {
 	case PIIX4_BYTE:
 	case PIIX4_BYTE_DATA:
-		data->byte =3D readb(virt_addr + SMBHSTDAT0);
+		data->byte =3D inb_p(SMBHSTDAT0);
 		break;
 	case PIIX4_WORD_DATA:
-		data->word =3D readb(virt_addr + SMBHSTDAT0)
-				+ (readb(virt_addr + SMBHSTDAT1) << 8);
+		data->word =3D inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
 		break;
 	case PIIX4_BLOCK_DATA:
-		data->block[0] =3D readb(virt_addr + SMBHSTDAT0);
+		data->block[0] =3D inb_p(SMBHSTDAT0);
 		if (data->block[0] =3D=3D 0 || data->block[0] > I2C_SMBUS_BLOCK_MAX)
 			return -EPROTO;
-		i =3D readb(virt_addr + SMBHSTCNT); /* Reset SMBBLKDAT */
+		i =3D inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i =3D 1; i <=3D data->block[0]; i++)
-			data->block[i] =3D readb(virt_addr + SMBBLKDAT);
+			data->block[i] =3D inb_p(SMBBLKDAT);
 		break;
 	}
 	return 0;
 }
=20
-
-/*********************************************************************=
***/
-/** return capabilities of this Hardware
- *
- *  \return			capabilities flags
- */
-static u32 piix4_func(struct i2c_adapter *adapter) {
-	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BY=
TE_DATA
-			| I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA;
+static u32 piix4_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
 }
=20
-/*---------------- 1st Controller [SMBus0]----------------*/
-
-/* algorithm IO-mapped [SMBus0] */
-static const struct i2c_algorithm smbus_algorithm0 =3D {
-	.smbus_xfer =3D piix4_access_io,
-	.functionality =3D piix4_func,
-};
-
-/* i2c_adapter IO-mapped [SMBus0] */
-static struct i2c_adapter piix4_adapter0 =3D {
-	.owner =3D THIS_MODULE,
-	.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo =3D &smbus_algorithm0,
-};
-
-/*---------------- 2nd Controller [SMBus1]----------------*/
-
-/* algorithm MEM-mapped [SMBus1] */
-static const struct i2c_algorithm smbus_algorithm1 =3D {
-	.smbus_xfer =3D piix4_access_mem,
+static const struct i2c_algorithm smbus_algorithm =3D {
+	.smbus_xfer	=3D piix4_access,
 	.functionality =3D piix4_func,
 };
=20
-/* algorithm IO-mapped [SMBus1] */
-static const struct i2c_algorithm smbus_algorithm2 =3D {
-	.smbus_xfer =3D sec_piix4_access_io,
-	.functionality =3D piix4_func,
-};
-
-/* i2c_adapter MEM-mapped [SMBus1] */
-static struct i2c_adapter piix4_adapter1 =3D {
-	.owner =3D THIS_MODULE,
-	.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo =3D &smbus_algorithm1,
-};
-
-/* i2c_adapter IO-mapped [SMBus1] */
-static struct i2c_adapter piix4_adapter2 =3D {
-	.owner =3D THIS_MODULE,
-	.class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD,
-	.algo =3D &smbus_algorithm2,
-};
-
-
-static const struct pci_device_id piix4_ids[] =3D
-		{
+static DEFINE_PCI_DEVICE_TABLE(piix4_ids) =3D {
 				{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3) }=
,
 				{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3) }=
,
 				{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3) },
@@ -1047,150 +531,143 @@ static const struct pci_device_id piix4_
 				{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
 				{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
 				{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) }=
,
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x790b) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_CSB5) },
 				{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
-						PCI_DEVICE_ID_SERVERWORKS_OSB4) }, { PCI_DEVICE(
-						PCI_VENDOR_ID_SERVERWORKS,
-						PCI_DEVICE_ID_SERVERWORKS_CSB5) }, { PCI_DEVICE(
-						PCI_VENDOR_ID_SERVERWORKS,
-						PCI_DEVICE_ID_SERVERWORKS_CSB6) }, { PCI_DEVICE(
-						PCI_VENDOR_ID_SERVERWORKS,
-						PCI_DEVICE_ID_SERVERWORKS_HT1000SB) }, { PCI_DEVICE(
-						PCI_VENDOR_ID_SERVERWORKS,
-						PCI_DEVICE_ID_SERVERWORKS_HT1100LD) }, { 0, } };
+		     PCI_DEVICE_ID_SERVERWORKS_CSB6) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_HT1000SB) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
+		     PCI_DEVICE_ID_SERVERWORKS_HT1100LD) },
+	{ 0, }
+};
+
 MODULE_DEVICE_TABLE (pci, piix4_ids);
=20
-/*********************************************************************=
***/
-/** Probing function for SMB Controller
- *				=09
- *  \param  *dev 	\IN PCI device struct
- *	\param  *id		\IN PCI device ID
- *
- *  \return				\c 0 On success or error code
- */
+static struct i2c_adapter *piix4_main_adapter;
+static struct i2c_adapter *piix4_aux_adapter;
=20
-static int piix4_probe(struct pci_dev *dev,
-		const struct pci_device_id *id)
+static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
+			     struct i2c_adapter **padap)
 {
-	/* 1 =3D Controller not in use */
-	int ctr1_retval =3D 1;
-	int ctr2_retval =3D 1;
-
-	mutex_init(&funcLock);
-	mutex_unlock(&funcLock);
+	struct i2c_adapter *adap;
+	struct i2c_piix4_adapdata *adapdata;
+	int retval;
=20
-	if ((dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
-					dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
-					dev->revision >=3D 0x40) ||
-			dev->vendor =3D=3D PCI_VENDOR_ID_AMD) {
-		/* base address location etc changed in SB800 */
-		ctr1_retval =3D piix4_setup_sb800(dev, id);
-		ctr2_retval =3D sec_piix4_setup_sb800(dev,id);
+	adap =3D kzalloc(sizeof(*adap), GFP_KERNEL);
+	if (adap =3D=3D NULL) {
+		release_region(smba, SMBIOSIZE);
+		return -ENOMEM;
 	}
-	else
-	ctr1_retval =3D piix4_setup(dev, id);
-
-	/* Is just the controller 1 in use, an has a fault? */
-	if (ctr1_retval !=3D 0 && ctr2_retval =3D=3D 1)
-	return ctr1_retval;
-
 =09
-	if( ctr1_retval =3D=3D 0 ) {
-		/* set up the sysfs linkage to our parent device */
-		piix4_adapter0.dev.parent =3D &dev->dev;
-
-		snprintf(piix4_adapter0.name, sizeof(piix4_adapter0.name),
-				"SMBus PIIX4 adapter at 0x%04x", piix4_smba0);
+	adap->owner =3D THIS_MODULE;
+	adap->class =3D I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	adap->algo =3D &smbus_algorithm;
=20
-		/* Add 1st I2C adapter */
-		if ((ctr1_retval =3D i2c_add_adapter(&piix4_adapter0))) {
-			dev_err(&dev->dev, "Couldn't register adapter 0!\n");
-			release_region(piix4_smba0, SMBIOSIZE);
-			piix4_smba0 =3D 0;
+	adapdata =3D kzalloc(sizeof(*adapdata), GFP_KERNEL);
+	if (adapdata =3D=3D NULL) {
+		kfree(adap);
+		release_region(smba, SMBIOSIZE);
+		return -ENOMEM;
 		}
=20
-		/* if the 2nd controller is not in use, probe is ready */
-		if(ctr2_retval =3D=3D 1)
-			return ctr1_retval;
-	}
+	adapdata->smba =3D smba;
=20
-	if( ctr2_retval =3D=3D 0 ) {
-		/* add adapter 1 if the [SMBus1] is MEM-mapped */
-		if(SMBusMap =3D=3D MEMMAP) {
-			piix4_adapter1.dev.parent =3D &dev->dev;
+	/* set up the sysfs linkage to our parent device */
+	adap->dev.parent =3D &dev->dev;
=20
-			snprintf(piix4_adapter1.name, sizeof(piix4_adapter1.name),
-					"SMBus PIIX4 2nd adapter at 0x%08x", piix4_smba1);
+	snprintf(adap->name, sizeof(adap->name),
+		"SMBus PIIX4 adapter at %04x", smba);
=20
-			ctr2_retval =3D i2c_add_adapter(&piix4_adapter1);
+	i2c_set_adapdata(adap, adapdata);
=20
+	retval =3D i2c_add_adapter(adap);
+	if (retval) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		kfree(adapdata);
+		kfree(adap);
+		release_region(smba, SMBIOSIZE);
+		return retval;
 		}
-		/* add adapter 2 if the [SMBus1] is IO-mapped */
-		else {
-			piix4_adapter2.dev.parent =3D &dev->dev;
=20
-			snprintf(piix4_adapter2.name, sizeof(piix4_adapter2.name),
-					"SMBus PIIX4 2nd adapter at 0x%08x", piix4_smba1);
+	*padap =3D adap;
+	return 0;
+}
=20
-			ctr2_retval =3D i2c_add_adapter(&piix4_adapter2);
+static int piix4_probe(struct pci_dev *dev, const struct pci_device_id=
 *id)
+{
+	int retval;
=20
-		}
+	if ((dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
+	     dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
+	     dev->revision >=3D 0x40) ||
+	    dev->vendor =3D=3D PCI_VENDOR_ID_AMD)
+		/* base address location etc changed in SB800 */
+		retval =3D piix4_setup_sb800(dev, id, 0);
+	else
+		retval =3D piix4_setup(dev, id);
=20
-		/* Could the adapter of the [SMBus1] be added? */
-		if( ctr2_retval ) {
-			dev_err(&dev->dev, "Couldn't register SMBus adapter 1!\n");
-			printk("Couldn=B4t register SMBus adapter 1\n");
-			relAdressSpace(piix4_smba1, SMBMSIZE,SMBusMap);
-			piix4_smba1 =3D 0;
+	/* If no main SMBus found, give up */
+	if (retval < 0)
+		return retval;
+
+	/* Try to register main SMBus adapter, give up if we can't */
+	retval =3D piix4_add_adapter(dev, retval, &piix4_main_adapter);
+	if (retval < 0)
+		return retval;
+
+	/* Check for auxiliary SMBus on some AMD chipsets */
+	retval =3D -ENODEV;
+
+	if (dev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
+	    dev->device =3D=3D PCI_DEVICE_ID_ATI_SBX00_SMBUS) {
+		if (dev->revision < 0x40) {
+			retval =3D piix4_setup_aux(dev, id, 0x58);
+		} else {
+			/* SB800 added aux bus too */
+			retval =3D piix4_setup_sb800(dev, id, 1);
 		}
 	}
=20
+	if (dev->vendor =3D=3D PCI_VENDOR_ID_AMD &&
+	    dev->device =3D=3D PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) {
+		retval =3D piix4_setup_sb800(dev, id, 1);
+	}
=20
-	/* if both I2C Controller couldn=B4t initialize =3D> there is no Cont=
roller */
-	if( ctr1_retval && ctr2_retval )
-		return -ENODEV;
-
-	/* if Controller 1 couldn=B4t initialize */
-	if( ctr1_retval )
-		printk("SMBus0 could not be initialize\n");
-
-	/* if Controller 2 couldn=B4t initialize */
-	if( ctr2_retval )
-		printk("SBus1 could not be intitialize\n");
+	if (retval > 0) {
+		/* Try to add the aux adapter if it exists,
+		 * piix4_add_adapter will clean up if this fails */
+		piix4_add_adapter(dev, retval, &piix4_aux_adapter);
+	}
=20
 	return 0;
 }
=20
-
-/*********************************************************************=
***/
-/** Removing function for SMB Controller
- *				=09
- *  \param  *dev 	\IN PCI device struct
- *
- *  \return			-
- */
-static void piix4_remove(struct pci_dev *dev)
+static void piix4_adap_remove(struct i2c_adapter *adap)
 {
-	if (piix4_smba0) {
-		i2c_del_adapter(&piix4_adapter0);
-		release_region(piix4_smba0, SMBIOSIZE);
-		piix4_smba0 =3D 0;
-	}
+	struct i2c_piix4_adapdata *adapdata =3D i2c_get_adapdata(adap);
=20
-	/* release mem region of 2nd Controller  [SMBus1] */
-	if (piix4_smba1) {
-		if(SMBusMap =3D=3D MEMMAP) {
-			i2c_del_adapter(&piix4_adapter1);
-			release_mem_region(piix4_smba1, SMBMSIZE);
-
-			/* unmap the virtual adress */
-			iounmap(virt_addr);
+	if (adapdata->smba) {
+		i2c_del_adapter(adap);
+		release_region(adapdata->smba, SMBIOSIZE);
+		kfree(adapdata);
+		kfree(adap);
 		}
-		else if(SMBusMap =3D=3D IOMAP) {
-			i2c_del_adapter(&piix4_adapter2);
-			release_region(piix4_smba1, SMBMSIZE);
+}
+
+static void piix4_remove(struct pci_dev *dev)
+{
+	if (piix4_main_adapter) {
+		piix4_adap_remove(piix4_main_adapter);
+		piix4_main_adapter =3D NULL;
 		}
=20
-		piix4_smba1 =3D 0;
+	if (piix4_aux_adapter) {
+		piix4_adap_remove(piix4_aux_adapter);
+		piix4_aux_adapter =3D NULL;
 	}
 }
=20
@@ -1198,23 +675,12 @@ static struct pci_driver piix4_driver =3D
 	.name =3D "piix4_smbus",
 	.id_table =3D piix4_ids,
 	.probe =3D piix4_probe,
-//	.remove =3D __devexit_p(piix4_remove),
+	.remove		=3D piix4_remove,
 };
=20
-static int __init i2c_piix4_init(void)
-{
-	return pci_register_driver(&piix4_driver);
-}
-
-static void __exit i2c_piix4_exit(void)
-{
-	pci_unregister_driver(&piix4_driver);
-}
+module_pci_driver(piix4_driver);
=20
 MODULE_AUTHOR("Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org> and "
 		"Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>");
 MODULE_DESCRIPTION("PIIX4 SMBus driver");
 MODULE_LICENSE("GPL");
-
-module_init(i2c_piix4_init);
-module_exit(i2c_piix4_exit);




--=20
Dr. Christian Herzog <herzog-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>  support: +41 44 633 26 68
IT Services Group, HPT H 8                    voice: +41 44 633 39 50
Department of Physics, ETH Zurich          =20
8093 Zurich, Switzerland                     http://nic.phys.ethz.ch/
