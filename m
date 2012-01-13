From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
Subject: Re: [i2c-mpc.c] adding entry for mpc8360
Date: Fri, 13 Jan 2012 08:26:34 +0100
Message-ID: <4F0FDCAA.1040203@denx.de>
References: <4F0EFD78.3020708@ruggedcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4F0EFD78.3020708-4VtgCsEi+FIybS5Ee8rs3A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Retanubun <richardretanubun-4VtgCsEi+FIybS5Ee8rs3A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

I added the "devicetree-discuss" ml.

On 01/12/2012 04:34 PM, Richard Retanubun wrote:
> Hello,
> 
> I am wondering if it is okay to add .compatible entries for mpc8360 and
> declare its data structure
> to mpc-i2c.c
> 
> something like this:
> 
> {.compatible = "fsl,mpc8360-i2c", .data = &mpc_i2c_data_8360, },
> 
> static struct mpc_i2c_data mpc_i2c_data_8360 __devinitdata = {
>     .setup = mpc_i2c_setup_8xxx,
> };
> 
> or is the intended approach to match the closest thing to your CPU (in
> this case mpc8313) ?

Yes, it is intended to use the name of the compatible device, see:

http://lxr.linux.no/#linux+v3.2.1/arch/powerpc/boot/dts/kmeter1.dts#L69

Wolfgang
