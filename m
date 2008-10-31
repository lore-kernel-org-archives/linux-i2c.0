From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
 filter.
Date: Fri, 31 Oct 2008 14:22:35 -0700
Message-ID: <490B771B.2080901@consentry.com>
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <490AEEBF.9000707-NIgtFMG+Po8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[redirecting again to the new i2c mailing list]

Jochen Friedrich wrote:
> What needs to be done though is to document this change in
> Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt.

How about the below?

I'll wait for David to comment on the property name and for any suggestions
on the documentation below, then I'll submit a new patch.

					-=] Mike [=-

--- linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	11 Oct 2008 02:49:31 -0000	1.1.1.1
+++ linux/Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt	31 Oct 2008 21:15:06 -0000
@@ -10,8 +10,12 @@
 - #address-cells : Should be one. The cell is the i2c device address with
   the r/w bit set to zero.
 - #size-cells : Should be zero.
-- clock-frequency : Can be used to set the i2c clock frequency. If
-  unspecified, a default frequency of 60kHz is being used.
+- clock-frequency : Can be used to set the desired i2c clock frequency (in Hz).
+  If unspecified, a default of 60 kHz is being used.  The actual frequency may
+  be somewhat higher than this value, depending on how the BRG_CLK and dividers
+  work out.
+- clock-filter : boolean; if defined, indicates that this controller
+  should enable the SCL digital filter.
 The following two properties are deprecated. They are only used by legacy
 i2c drivers to find the bus to probe:
 - linux,i2c-index : Can be used to hard code an i2c bus number. By default,
