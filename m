From: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
Date: Fri, 5 Feb 2010 03:12:16 -0800
Message-ID: <f17812d71002050312o3625caaake318e909e09f2cd0@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	<20100204103530.65429c04@hyperion.delvare> <309424b61002040438i2fae055dt2d3ef528eae99b48@mail.gmail.com>
	<f17812d71002040447y4b6f889o1137ae6149559994@mail.gmail.com>
	<20100204141451.3e0f865e@hyperion.delvare> <309424b61002042151i2a762d41md3521a820fd45622@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <309424b61002042151i2a762d41md3521a820fd45622-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Hi, Jean
>
> Thanks for your instruction.
> Here is patch to modify some comments of i2c_master_send &
> i2c_master_recv, is this OK.
>

Where's the screaming things, dude?

> Thanks
> Zhangfei
>
> From 30fbf1ebf1facba3d280c887e2ecfd0499e7b04b Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Date: Sat, 6 Feb 2010 05:38:59 +0800
> Subject: [PATCH] i2c: notes of i2c_master_send & i2c_master_recv
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_master_send & i2c_master_recv not supp=
ort more than 64bytes
> transfer, since msg.len is __u16 type
>
> Signed-off-by: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> ---
> =C2=A0Documentation/i2c/writing-clients | =C2=A0 =C2=A03 ++-
> =C2=A0drivers/i2c/i2c-core.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A04 ++--
> =C2=A0include/linux/i2c.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A01 +
> =C2=A03 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/i2c/writing-clients
> b/Documentation/i2c/writing-clients
> index 7860aaf..929a3c3 100644
> --- a/Documentation/i2c/writing-clients
> +++ b/Documentation/i2c/writing-clients
> @@ -318,7 +318,8 @@ Plain I2C communication
> =C2=A0These routines read and write some bytes from/to a client. The =
client
> =C2=A0contains the i2c address, so you do not have to include it. The=
 second
> =C2=A0parameter contains the bytes to read/write, the third the numbe=
r of bytes
> -to read/write (must be less than the length of the buffer.) Returned=
 is
> +to read/write (must be less than the length of the buffer, also shou=
ld be
> +less than 64K since msg.len is __u16 type.) Returned is
> =C2=A0the actual number of bytes read/written.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i2c_transfer(struct i2c_adapter *adap,=
 struct i2c_msg *msg,
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 8d80fce..9607dcc 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -1112,7 +1112,7 @@ EXPORT_SYMBOL(i2c_transfer);
> =C2=A0* i2c_master_send - issue a single I2C message in master transm=
it mode
> =C2=A0* @client: Handle to slave device
> =C2=A0* @buf: Data that will be written to the slave
> - * @count: How many bytes to write
> + * @count: How many bytes to write, should be less than 64K since
> msg.len is u16
> =C2=A0*
> =C2=A0* Returns negative errno, or else the number of bytes written.
> =C2=A0*/
> @@ -1139,7 +1139,7 @@ EXPORT_SYMBOL(i2c_master_send);
> =C2=A0* i2c_master_recv - issue a single I2C message in master receiv=
e mode
> =C2=A0* @client: Handle to slave device
> =C2=A0* @buf: Where to store data read from slave
> - * @count: How many bytes to read
> + * @count: How many bytes to read, should be less than 64K since msg=
=2Elen is u16
> =C2=A0*
> =C2=A0* Returns negative errno, or else the number of bytes read.
> =C2=A0*/
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 57d41b0..b2dea18 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -53,6 +53,7 @@ struct i2c_board_info;
> =C2=A0* on a bus (or read from them). Apart from two basic transfer f=
unctions to
> =C2=A0* transmit one message at a time, a more complex version can be=
 used to
> =C2=A0* transmit an arbitrary number of messages without interruption=
=2E
> + * Parameter count should be less than 64K since msg.len is __u16
> =C2=A0*/
> =C2=A0extern int i2c_master_send(struct i2c_client *client, const cha=
r *buf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 int count);
> --
> 1.6.0.4
>
