From: "Lindsey Ings -X (ingsl - Yoh Services LLC at Cisco)"
	<ingsl-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Subject: RE: Sample DTS entries and sample user space code
Date: Fri, 10 Jul 2009 17:09:47 -0400
Message-ID: <50A8E1F8D9122546A7F67134915EDB7AB91AB4@xmb-rtp-21a.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-class: urn:content-classes:message
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



Resend of message in plain text form.


I understand the concepts involved in this project but that doesn't hel=
p me actually make use of it.

Is there a sample of how to put the mux and (if feasible) I2C clients i=
n a DTS?

Also is there a user application sample of how to access the devices do=
wnstream from the mux?=A0 Are the mux's created as a device so that the=
 devices downstream are accessed as non-mux'd devices?=A0 i.e. is dev D=
 in segment 2 (from the diagram on the wiki) accessed as so:

int fd;
fd =3D open( "/dev/i2c-2", O_RDWR );

#define ADDRESS 0x38 // address of dev D
ioctl( fd, I2C_SLAVE, ADDRESS )

// Now r/w dev D

// Write 0xAA to dev D
i2c_smbus_write_byte( fd, 0xAA );
// etc.
