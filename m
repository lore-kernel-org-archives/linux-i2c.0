From: Antony Pavlov <antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: i2c: i2c-mv64xxx: rework offload support to fix several
 problems
Date: Sat, 4 Jul 2015 09:59:08 +0300
Message-ID: <20150704095908.18a15912ceff03764ed15ff1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

I have found your commit in the linux kernel mainline

  commit 00d8689b85a7bb37cc57ba4c40bd46325f51ced4
  Author: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
  Date:   Thu Dec 11 17:33:46 2014 +0100

      i2c: mv64xxx: rework offload support to fix several problems

see also https://patchwork.ozlabs.org/patch/420180/

Here is a fragment:

+static bool
+mv64xxx_i2c_can_offload(struct mv64xxx_i2c_data *drv_data)
+{
+	struct i2c_msg *msgs =3D drv_data->msgs;
+	int num =3D drv_data->num_msgs;
+
+	return false;
^^^^^^^^^^^^^^^^^^^^^
+
+	if (!drv_data->offload_enabled)
+		return false;

So mv64xxx_i2c_can_offload() is always returns false and offload is alw=
ays disabled.

Please comment this.

--=A0
Best regards,
=A0 Antony Pavlov
