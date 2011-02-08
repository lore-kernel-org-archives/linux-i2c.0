From: David St-Onge <david.st-onge.2-qLLbaQniQ8D3fQ9qLvQP4Q@public.gmane.org>
Subject: Another HMC6343 I2C reading problem
Date: Tue, 8 Feb 2011 18:42:30 -0500
Message-ID: <3C919C27AD894941B99EFB6E2E8A000D01A1C4686E2A@EXCH-MBX-F.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: fr-CA
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi all!!

I was wondering if anyone succeed on using this compass/tilt sensor (http://article.gmane.org/gmane.linux.drivers.i2c/3933/match=hmc6343), without the I2C kernel module?

To summarize the challenge here, this device reply to a byte command with 6 bytes before its stop, and it also need a custom delay (1ms) between the read and write commands.

Using:
adresse=0x32;
command1=0x50; //0x50:Headings, 0x55:Tilt, 0x45:Magneto
union i2c_smbus_data sixbuff;
if (ioctl(file, I2C_SLAVE, adresse >> 1) >= 0) {
i2c_smbus_access(file, I2C_SMBUS_WRITE, command1, I2C_SMBUS_BYTE, NULL);
usleep(1000);
i2c_smbus_access(file, I2C_SMBUS_READ, 0, I2C_SMBUS_BYTE, &sixbuff);
}

My first 2 values are corrects (Heading) but the 2 others don't vary.... never (for 0x45 and 0x55 commands also).

Anyone used the i2c-dev.h userspace functions with this device?

Thanks!
Dave.
