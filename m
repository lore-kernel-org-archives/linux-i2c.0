From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] i2c: iProc: define Broadcom iProc I2C binding
Date: Tue, 9 Dec 2014 19:27:17 -0800
Message-ID: <5487BD95.1060000@broadcom.com>
References: <rjui@broadcom.com>	<1418172891-19441-1-git-send-email-rjui@broadcom.com>	<1418172891-19441-2-git-send-email-rjui@broadcom.com>	<5487A16C.5000707@gmail.com>	<5487A355.6030704@broadcom.com> <CAEUmHyb_wu1kVj-G5LQj8Q_A1Tid1gSGbU=cGeBf4EXZgXChbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEUmHyb_wu1kVj-G5LQj8Q_A1Tid1gSGbU=cGeBf4EXZgXChbg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On 12/9/2014 7:12 PM, Varka Bhadram wrote:
>
>
> On Wed, Dec 10, 2014 at 7:05 AM, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
> <mailto:rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>> wrote:
>
>
>
>     On 12/9/2014 5:27 PM, Varka Bhadram wrote:
>
>         Hi,
>
>         On Wednesday 10 December 2014 06:24 AM, Ray Jui wrote:
>
>             Document the I2C device tree binding for Broadcom iProc
>             family of
>             SoCs
>
>             Signed-off-by: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>             <mailto:rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>>
>             Reviewed-by: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
>             <mailto:sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>>
>             ---
>                .../devicetree/bindings/i2c/__brcm,iproc-i2c.txt     |   37
>             ++++++++++++++++++++
>                1 file changed, 37 insertions(+)
>                create mode 100644
>             Documentation/devicetree/__bindings/i2c/brcm,iproc-i2c.__txt
>
>             diff --git
>             a/Documentation/devicetree/__bindings/i2c/brcm,iproc-i2c.__txt
>             b/Documentation/devicetree/__bindings/i2c/brcm,iproc-i2c.__txt
>             new file mode 100644
>             index 0000000..81f982c
>             --- /dev/null
>             +++
>             b/Documentation/devicetree/__bindings/i2c/brcm,iproc-i2c.__txt
>             @@ -0,0 +1,37 @@
>             +Broadcom iProc I2C controller
>             +
>             +Required properties:
>             +
>             +- compatible:
>             +    Must be "brcm,iproc-i2c"
>             +
>             +- reg:
>             +    Define the base and range of the I/O address space that
>             contain
>             the iProc
>             +    I2C controller registers
>             +
>             +- interrupts:
>             +    Should contain the I2C interrupt
>             +
>             +- clock-frequency:
>             +    This is the I2C bus clock. Need to be either 100000 or
>             400000
>             +
>             +- #address-cells:
>             +    Always 1 (for I2C addresses)
>             +
>             +- #size-cells:
>             +    Always 0
>             +
>
>
>         All the properties defined with two lines of statements.
>
>         Why cant they be with single line statement, like:
>
>         compatible:    Must be "brcm,iproc-i2c"
>         reg:        Define the base and range of the I/O address space that
>                   contain the iProc I2C controller registers
>
>         ....
>
>
>     I thought making them two lines are more readable (and obviously
>     that's very subjective, :)). But more importantly, it matches the
>     format of other Broadcom iProc/Cygnus devicetree binding documents
>     that are currently in progress of upstreaming.
>
>
> But max of the bindings over the kernel follows single line statements.
>
> --
> Thanks and Regards,
> Varka Bhadram.
Is it a requirement for these property descriptions to be one line? If 
not, I prefer to stick with the way it is now. Thanks.
