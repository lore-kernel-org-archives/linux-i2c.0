From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: Add support for Ux500/Nomadik I2C controller
Date: Mon, 25 Jan 2010 14:07:52 +0100
Message-ID: <63386a3d1001250507u4144107fg39759ba8c3f62e54@mail.gmail.com>
References: <cover.1262944133.git.srinidhi.kasagar@stericsson.com>
	 <8abc7907a748a8a59852e46985361de1333f3c7a.1262944133.git.srinidhi.kasagar@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8abc7907a748a8a59852e46985361de1333f3c7a.1262944133.git.srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, sachin.verma-qxv4g6HH51o@public.gmane.org, rubini-9wsNiZum9E8@public.gmane.org, andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Srinidhi, some more small comments...

2010/1/8 srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>:

> This adds support for the ST-Ericsson's I2C
> block found in Ux500 and Nomadik 8815
> platforms.
>
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Acked-by: Andrea gallo <andrea.gallo-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> Acked-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

It's even Reviewed-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> now=
 that
I've taken some time to do it properly.

> +static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap);
> +static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
> +               struct i2c_msg msgs[], int num_msgs);
> +
> +static const struct i2c_algorithm nmk_i2c_algo =3D {
> +       .master_xfer    =3D nmk_i2c_xfer,
> +       .functionality  =3D nmk_i2c_functionality
> +};
> +
> +static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
> +{
> +       return I2C_FUNC_I2C
> +               | I2C_FUNC_SMBUS_BYTE_DATA
> +               | I2C_FUNC_SMBUS_WORD_DATA
> +               | I2C_FUNC_SMBUS_I2C_BLOCK;
> +}
> +

If you move nmk_i2c_functionality() before struct i2c_algorithm nmk_i2c=
_algo
and then move the whole shebang just before the probe() function you do=
n't
need to forward-declare nmk_i2c_functionality() and nmk_i2c_xfer().

(...)
> +/**
> + * nmk_i2c_xfer() - I2C transfer function used by kernel framework
> + * @i2c_adap =A0 - Adapter pointer to the controller
> + * @msgs[] - Pointer to data to be written.
> + * @num_msgs - Number of messages to be executed
> + *
> + * This is the function called by the generic kernel i2c_transfer()
> + * or i2c_smbus...() API calls. Note that this code is protected by =
the
> + * semaphore set in the kernel i2c_transfer() function.
> + *
> + * NOTE:
> + * READ TRANSFER : We impose a restriction of the first message to b=
e the
> + * =A0 =A0 =A0 =A0 =A0 =A0 index message for any read transaction.
> + * =A0 =A0 =A0 =A0 =A0 =A0 - a no index is coded as '0',
> + * =A0 =A0 =A0 =A0 =A0 =A0 - 2byte big endian index is coded as '3'
> + * =A0 =A0 =A0 =A0 =A0 =A0 !!! msg[0].buf holds the actual index.
> + * =A0 =A0 =A0 =A0 =A0 =A0 This is compatible with generic messages =
of smbus emulator
> + * =A0 =A0 =A0 =A0 =A0 =A0 that send a one byte index.
> + * =A0 =A0 =A0 =A0 =A0 =A0 eg. a I2C transation to read 2 bytes from=
 index 0
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D 0;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].addr =3D client->a=
ddr;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].flags =3D 0x0;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].len =3D 1;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].buf =3D &idx;
> + *
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[1].addr =3D client->a=
ddr;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[1].flags =3D I2C_M_RD=
;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[1].len =3D 2;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[1].buf =3D rd_buff
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_transfer(adap, msg, 2=
);
> + *
> + * WRITE TRANSFER : The I2C standard interface interprets all data a=
s payload.
> + * =A0 =A0 =A0 =A0 =A0 =A0 If you want to emulate an SMBUS write tra=
nsaction put the
> + * =A0 =A0 =A0 =A0 =A0 =A0 index as first byte(or first and second) =
in the payload.
> + * =A0 =A0 =A0 =A0 =A0 =A0 eg. a I2C transation to write 2 bytes fro=
m index 1
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_buff[0] =3D 0x1;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_buff[1] =3D 0x23;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wr_buff[2] =3D 0x46;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].flags =3D 0x0;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].len =3D 3;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg[0].buf =3D wr_buff;
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c_transfer(adap, msg, 1=
);
> + *
> + * To read or write a block of data (multiple bytes) using SMBUS emu=
lation
> + * please use the i2c_smbus_read_i2c_block_data()
> + * or i2c_smbus_write_i2c_block_data() API
> + *
> + * i2c_master_recv() API is not supported as single read message is =
not
> + * accepted by our interface (it has to be preceded by an index mess=
age)

It looks like this restriction is gone, so the comment can go too?

> + */
> +static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct i2c_msg msgs[], int num_msgs)
> +{
> + =A0 =A0 =A0 int status;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u32 cause;
> + =A0 =A0 =A0 struct nmk_i2c_dev *dev =3D i2c_get_adapdata(i2c_adap);
> +
> + =A0 =A0 =A0 status =3D init_hw(dev);
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> +
> + =A0 =A0 =A0 /* setup the i2c controller */
> + =A0 =A0 =A0 setup_i2c_controller(dev);
> +
> + =A0 =A0 =A0 for (i =3D 0; i < num_msgs; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(msgs[i].flags & I2C_M_TEN)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->pdev->dev=
, "10 bit addressing"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "not supported\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cli.slave_adr =A0 =A0 =A0=3D msgs[=
i].addr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cli.buffer =A0 =A0 =A0 =A0 =3D msg=
s[i].buf;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cli.count =A0 =A0 =A0 =A0 =A0=3D m=
sgs[i].len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->stop =3D (i < (num_msgs - 1)) ? 0 =
: 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->result =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msgs[i].flags & I2C_M_RD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* it is a read operati=
on */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cli.operation =3D =
I2C_READ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D read_i2c(dev=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* write operation */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->cli.operation =3D =
I2C_WRITE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D write_i2c(de=
v);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status || (dev->result)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* get the abort cause =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cause =3D (readl(dev->v=
irtbase + I2C_SR) >> 4) & 0x7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->pdev->dev=
, "error during I2C"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "message xfer: %d\n", cause);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->pdev->dev=
, "%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cause >=
=3D ARRAY_SIZE(abort_causes)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ? "unkn=
own reason" : abort_causes[cause]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return status;
> +}
> +

This thing should return the number of messages transferred, see
include/linux/i2c.h.

Something like
if (status)
  return status;
else
  return i;

should work I think?

Yours,
Linus Walleij
