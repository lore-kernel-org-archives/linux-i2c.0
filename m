From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: [PATCH 2/4] i2c: imx: only imx1 needs disable delay
Date: Thu, 1 Oct 2009 15:52:15 +0800
Message-ID: <4e090d470910010052k37a0a4eep6d436e45e6524234@mail.gmail.com>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	<20091001072643.GW27039@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091001072643.GW27039@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, kernel@pengutronix.de, w.sang@pengutronix.de
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 1, 2009 at 3:26 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Oct 01, 2009 at 09:13:31AM +0800, Richard Zhao wrote:
>> check cpu_is_mx1() when set disable_delay.
>>
>> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 156cc95..c1e541c 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -254,14 +254,16 @@ static void __init i2c_imx_set_clk(struct imx_i2c_=
struct *i2c_imx,
>> =A0 =A0 =A0 /* Write divider value to register */
>> =A0 =A0 =A0 writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* There dummy delay is calculated.
>> - =A0 =A0 =A0* It should be about one I2C clock period long.
>> - =A0 =A0 =A0* This delay is used in I2C bus disable function
>> - =A0 =A0 =A0* to fix chip hardware bug.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_div[i][0]
>> - =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>> + =A0 =A0 if (cpu_is_mx1()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* There dummy delay is calculated.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* It should be about one I2C clock period l=
ong.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* This delay is used in I2C bus disable fun=
ction
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* to fix chip hardware bug.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2c_imx->disable_delay =3D (500000U * i2c_clk_=
div[i][0]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + (i2c_clk_rate / 2) - 1) / (i=
2c_clk_rate / 2);
>> + =A0 =A0 }
>
> I think you should put the udelay(i2c_imx->disable_delay) in
> cpu_is_mx1() rather than the calculation.
>
> Sascha
>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
Do you think udelay(0) wast any more time than if()?
And Could I get all you comments in a single patch loop?

Thanks
Richard
