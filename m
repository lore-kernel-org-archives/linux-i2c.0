From: =?UTF-8?Q?Amaury_Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: sis964: bus driver
Date: Wed, 18 Jul 2012 13:57:54 +0200
Message-ID: <CAPXEm70iiU-OQ4DbmBaPzk-WTxBLzvEPSTrRwcn073q9DFs08A@mail.gmail.com>
References: <1342172455-8530-1-git-send-email-amaury.decreme@gmail.com>
 <CAErSpo5-ou3vjmHgjiOOd57PvWg_hez80U0k3AX_ydjb0pikvQ@mail.gmail.com> <20120715133530.1ffc3f36@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120715133530.1ffc3f36-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, jeffrey.t.kirsher-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org, Xiangzhen.Ye-kQvG35nSl+M@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hi3766691-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,


=46or the v2 of this patch, I will remove the modifications on
include/linux/pci_ids.h

 include/linux/pci_ids.h             |    1 +
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index ab741b0..0ffc982 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -699,6 +699,7 @@
 #define PCI_DEVICE_ID_SI_961           0x0961
 #define PCI_DEVICE_ID_SI_962           0x0962
 #define PCI_DEVICE_ID_SI_963           0x0963
+#define PCI_DEVICE_ID_SI_964           0x0964
 #define PCI_DEVICE_ID_SI_965           0x0965
 #define PCI_DEVICE_ID_SI_966           0x0966
 #define PCI_DEVICE_ID_SI_968           0x0968


And will add this to drivers/i2c/busses/i2c-sis964.c directly as
i2c-sis964 will be the only file needing this define
+#define PCI_DEVICE_ID_SI_964           0x0964



Amaury Decr=C3=AAme
