From: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] fix i2c_msg.len not aligning with i2c_master_send
Date: Thu, 4 Feb 2010 16:25:40 +0800
Message-ID: <309424b61002040025n22c2b05wbaab46ca4da946f2@mail.gmail.com>
References: <309424b61002032204y37307236q94ab3a502b0526e0@mail.gmail.com>
	 <20100204073759.GC13267@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100204073759.GC13267-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi, Ben

Thanks for your suggestion.

On Thu, Feb 4, 2010 at 3:37 PM, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:
>
> On Thu, Feb 04, 2010 at 02:04:03PM +0800, zhangfei gao wrote:
> > Hi, Jean
> >
> >
> > We found type of i2c_msg.len is __u16, while parameter count in
> > i2c_master_send is int.
> > The mismatch will truncate count from int to u16.
> > For example we downloading firmware which is more than 64K (64K+8) =
via i2c,
> > i2c would transfer u16 (8 bytes) in fact.
>
> I would be wary of changing the i2c_msg structure as this is exported=
 to
> userspace.
>
>
> I think a better fix would be to test the count parameter to i2c_mast=
er_send
> and return something like EMSGSIZE to inform the user it is too long.
>
> If you really want i2c transfers of 64K and above, then you might hav=
e to
> add a new struct i2c_msg and update all the callsites to use it. Eith=
er that
> or chain a set of msgs together and pass them to the i2c controller i=
n one
> go.
>
> Please discuss on the i2c list.
>

1. Both i2c_master_send and i2c_msg are exported in include/linux/i2c.h=
=2E
2. Both i2c_master_send and i2c_master_recv supposed to support int
count, is it suitable to return error when count is bigger than 64K?
3. It may impact a lot if adding new structure :)

include/linux/i2c.h
extern int i2c_master_send(struct i2c_client *client, const char *buf,
                           int count);
extern int i2c_master_recv(struct i2c_client *client, char *buf, int co=
unt);

Thansk
Zhangfei

> > >From 69ec7599bf0fa28441281be1df76a2f573bb9127 Mon Sep 17 00:00:00 =
2001
> > From: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > Date: Fri, 5 Feb 2010 05:12:19 +0800
> > Subject: [PATCH] i2c: i2c_msg.len modify to __u32 type
> >
> > =A0 =A0 int i2c_master_send(struct i2c_client *client,const char *b=
uf ,int
> > count)
> > =A0 =A0 {
> > =A0 =A0 =A0 =A0 ~
> > =A0 =A0 =A0 =A0 msg.len =3D count;
> > =A0 =A0 =A0 =A0 ~
> > =A0 =A0 }
> > =A0 =A0 Parameter count would truncate from int to __u16
> >
> > Signed-off-by: Zhangfei Gao <zgao6-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > ---
> > =A0include/linux/i2c.h | =A0 =A02 +-
> > =A01 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 57d41b0..4769ce9 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -491,7 +491,7 @@ struct i2c_msg {
> > =A0#define I2C_M_IGNORE_NAK =A0 =A00x1000 =A0 =A0/* if I2C_FUNC_PRO=
TOCOL_MANGLING */
> > =A0#define I2C_M_NO_RD_ACK =A0 =A0 =A0 =A00x0800 =A0 =A0/* if I2C_F=
UNC_PROTOCOL_MANGLING
> > */
> > =A0#define I2C_M_RECV_LEN =A0 =A0 =A0 =A00x0400 =A0 =A0/* length wi=
ll be first received
> > byte */
> > - =A0 =A0__u16 len; =A0 =A0 =A0 =A0/* msg length =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*/
> > + =A0 =A0__u32 len; =A0 =A0 =A0 =A0/* msg length =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0*/
> > =A0 =A0 =A0__u8 *buf; =A0 =A0 =A0 =A0/* pointer to msg data =A0 =A0=
 =A0 =A0 =A0 =A0*/
> > =A0};
> >
> > --
> > 1.6.0.4
>
>
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
> --
> --
> Ben
>
> Q: =A0 =A0 =A0What's a light-year?
> A: =A0 =A0 =A0One-third less calories than a regular year.
>
