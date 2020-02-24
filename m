From: Andrij Abyzov <drolevar@gmail.com>
Subject: Re: Strange behavior in i2c-mpc
Date: Mon, 24 Feb 2020 16:23:20 +0100
Message-ID: <CADQNx5T1Sq0=-8vJzkDta4FsYhRGgbZzLfd5pxiSY+XWhhaskQ@mail.gmail.com>
References: <CADQNx5TaaJhCJMPQTtGrNibY082SmjVKa3EG9SDJPsteLnn41A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45028 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXPXd (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 24 Feb 2020 10:23:33 -0500
Received: by mail-ed1-f42.google.com with SMTP id g19so12274609eds.11
        for <linux-i2c@vger.kernel.org>; Mon, 24 Feb 2020 07:23:32 -0800 (PST)
In-Reply-To: <CADQNx5TaaJhCJMPQTtGrNibY082SmjVKa3EG9SDJPsteLnn41A@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org

Hi all,

I=E2=80=99m trying to implement the following transfer with the i2c-mpc dri=
ver:

Read MR: Initiate pressure management

+---------------------+
|S|6|5|4|3|2|1|0|R|A|S|
+---------------------+

First S - start condition
6:0 - slave address
R - read bit ('1')
A - wait for slave ACK
Second S - stop condition.

My guess was that doing that would be enough:

    struct i2c_msg msg =3D {
        .addr =3D <addr>,
        .flags =3D I2C_M_RD,
        .len =3D 0,
        .buf =3D NULL,
    };

    return i2c_transfer(data->client->adapter, &msg, 1);

However, when the length parameter is 0, the wait for the CSR_MBB bit
in lines 617-630 of mpc_xfer in drivers/i2c/busses/i2c-mpc.c times
out.

I=E2=80=99m checking the NXP P2020 spec, and it says that

     Note that a master can generate a STOP even if the slave has transmitt=
ed an
     acknowledge bit, at which point the slave must release the bus.

To me everything seems OK here, but still CSR_MBB never becomes zero.
Would you be able to give me any advice?

Best regards,
Andrij Abyzov
