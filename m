From: "Wen Wang" <sickdoctor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Question about i2c new style modle
Date: Sun, 12 Oct 2008 19:52:08 +0800
Message-ID: <56458e0810120452n2def8400n883ad46d0440e779@mail.gmail.com>
References: <56458e0810112335r529622dei4c6891465c6fdf88@mail.gmail.com>
	<20081012075715.GA26683@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4927435166591902306=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081012075715.GA26683-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============4927435166591902306==
Content-Type: multipart/alternative;
	boundary="----=_Part_26059_23495841.1223812328080"

------=_Part_26059_23495841.1223812328080
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 Hi Wolfram,

Thank you for your quick response, really appreciate.

You're saying "You supply i2c_board_info in your board init code and when
the
i2c adapter is initialized", but I'm quite sure there won't be a such
static i2c_board_info in the board init code.

And I'm just wonder if there is a dynamic detect method to go?

Here is my proposed code, can you please help to correct it if I'm wrong?

static const unsigned short normal_i2c[] = { DEVICE_ADDRESS, I2C_CLIENT_END
};
I2C_CLIENT_INSMOD(foo);

static int foo_detect(struct i2c_client *client, int kind,
                             struct i2c_board_info *info)
{
         /* Things here */
         return 0;
}

static int foo_probe(struct i2c_client *client,
                            const struct i2c_device_id *id)
{
          /* Things here */
         return 0;
}

static int foo_remove(struct i2c_client *client)
{
         /* Things here */
         return 0;
}

static const struct i2c_device_id foo_id[] = {
         { "foo", 0 },
         { }
};

static struct i2c_driver foo_driver = {
         .driver = {
                 .name = "foo",
         },
         .probe  = foo_probe,
         .remove  = foo_remove,
         .id_table = foo_id,
         .class  = I2C_CLASS_CAM_DIGITAL,
         .detect  = foo_detect,
         .address_data = &addr_data,
};

Best Regards
Wen

------=_Part_26059_23495841.1223812328080
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><div>
<div>Hi Wolfram,</div>
<div>&nbsp;</div>
<div>Thank you for your quick response, really appreciate.</div>
<div>&nbsp;</div>
<div>You&#39;re saying &quot;You supply i2c_board_info in your board init code and when the<br>i2c adapter is initialized&quot;, but I&#39;m quite sure there won&#39;t be a such static&nbsp;i2c_board_info in the board init code. </div>

<div>&nbsp;</div>
<div>And I&#39;m just wonder if there is a dynamic detect method to go?</div>
<div>&nbsp;</div>
<div>Here is my proposed code, can you please help to correct it if I&#39;m wrong?</div>
<div>&nbsp;</div>
<div>static const unsigned short normal_i2c[] = { DEVICE_ADDRESS, I2C_CLIENT_END };<br>I2C_CLIENT_INSMOD(foo);</div>
<div>&nbsp;</div>
<div>static int foo_detect(struct i2c_client *client, int kind,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;struct i2c_board_info *info)<br>{</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Things here */</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
<div>}</div>
<div>&nbsp;</div>
<div>static int foo_probe(struct i2c_client *client,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;const struct i2c_device_id *id)<br>{&nbsp; </div>
<div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Things here */</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div></div>
<div>}</div>
<div>&nbsp;</div>
<div>static int foo_remove(struct i2c_client *client)<br>{</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Things here */</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>}</div>
<div>&nbsp;</div>
<div>static const struct i2c_device_id foo_id[] = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{ &quot;foo&quot;, 0 },<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { }<br>};</div>
<div>&nbsp;</div>
<div>static struct i2c_driver foo_driver = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name&nbsp;= &quot;foo&quot;,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .probe&nbsp;&nbsp;= foo_probe,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove&nbsp;&nbsp;= foo_remove,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id_table&nbsp;= foo_id,</div>

<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .class&nbsp;&nbsp;= I2C_CLASS_CAM_DIGITAL,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .detect&nbsp;&nbsp;= foo_detect,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .address_data&nbsp;= &amp;addr_data,<br>};</div>
<div>&nbsp;</div>
<div>Best Regards</div>
<div>Wen</div></div></div>

------=_Part_26059_23495841.1223812328080--


--===============4927435166591902306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4927435166591902306==--
