From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] dt-bindings: i2c: add bindings for nxp,pca9541
Date: Mon, 27 Jun 2016 18:27:21 +0200
Message-ID: <d7476000-e50c-b840-00a5-7eab1a0823fb@axentia.se>
References: <1467022282-21062-1-git-send-email-peda@axentia.se>
 <57712770.3040204@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0141.outbound.protection.outlook.com ([157.56.112.141]:37536
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751634AbcF0Q1m (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 12:27:42 -0400
In-Reply-To: <57712770.3040204@roeck-us.net>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jiri Slaby <jslaby@suse.cz>, linux-i2c@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 2016-06-27 15:17, Guenter Roeck wrote:
> On 06/27/2016 03:11 AM, Peter Rosin wrote:
>> Fill the gap for this pre-existing driver.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>   .../devicetree/bindings/i2c/i2c-arb-pca9541.txt    | 33 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  1 +
>>   2 files changed, 34 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
>>
>> Hi!
>>
>> I'm wondering about this driver. It is not a trivial device, and yet it
>> has historically relied on the i2c core matching the chip w/o vendor
>> prefix. This is not ideal. But what to do about the driver implementing
>> this in terms of an i2c-mux, somthing which the chip is not; It is an
>> i2c arbitrator. It just happens to rely on the i2c mux core also handling
>> i2c gates and i2c arbitrators. But that seems like a Linux detail. So I
>> don't know what to do here?
>>
> 
> The concept of arbitrators didn't exist when I wrote the driver. I would not
> have a problem with renaming the file if that is what you are asking for.

No, that was not my issue, I just wanted to document bindings for pca9541,
and I didn't like how it turned out.

I don't really care if the bindings doc is named i2c-mux-pca9541.txt (that
would match the name of the driver, but it still wouldn't make the chip a mux).

>> That is, the patch - as is - describes something that would be trivial to
>> support today, but at the same time it seems to be too tied to Linux.
>>
>> The problem is that the i2c@0 intermediate node is not really needed, but
>> at the same time removing it would cause a disruption for the driver since
>> it can't really use the i2c mux core if that node isn't there. I don't
>> see a simple way to fix that in the i2c mux core either (but admittedly
>> haven't given it too much thought).
>>
> 
> The gpio arbitrator uses the same principle as well. Why not just leave it
> alone ? Besides, I think it is a good idea to have it, since it groups
> the i2c devices behind the chip together. I would not consider that to be
> a Linuxism, but a design choice.

The grouping argument would make sense if there was anything outside the
group. Also, the required reg property and the extra #address-cells and
#size-cells doesn't add anything and just gets in the way, and is indeed
the result of Linuxisms leaking back into device trees.

If there were no muxes and this was a new driver, the example bindings
would almost certainly have been something like:

	i2c-arbitrator@74 {
		compatible = "nxp,pca9541";
		reg = <0x74>;

		#address-cells = <1>;
		#size-cells = <0>;

		eeprom@54 {
			compatible = "at,24c08";
			reg = <0x54>;
		};
	};

which I find much nicer.

But, I can't find a way to implement that and keep backwards compatibility
with old existing device trees.

Which is why I submitted the patch I did. It documents the pca9541 bindings,
something which is lacking, in terms of i2c-mux as the driver is written.
At the same time, this feels ugly and exposes linuxism and I wanted to make
that clear up front. The above simply looks better than the example in the
patch.

I intended to mark the submission [RFC PATCH], but I now realize that that
went missing along the way, sorry.

Cheers,
Peter

> Guenter
> 
>> Any suggestions?
>>
>> Cheers,
>> Peter
>>
>> PS. The driver source is in drivers/i2c/muxes/i2c-mux-pca9541.c
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
>> new file mode 100644
>> index 000000000000..edbe84935906
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-arb-pca9541.txt
>> @@ -0,0 +1,33 @@
>> +* NXP PCA9541 I2C bus master selector
>> +
>> +Required Properties:
>> +
>> +  - compatible: Must be "nxp,pca9541"
>> +
>> +  - reg: The I2C address of the device.
>> +
>> +  The following required properties are defined externally:
>> +
>> +  - Standard I2C mux properties. See i2c-mux.txt in this directory.
>> +  - I2C child bus nodes. See i2c-mux.txt in this directory.
>> +
>> +
>> +Example:
>> +
>> +	i2c-arbitrator@74 {
>> +		compatible = "nxp,pca9541";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <0x74>;
>> +
>> +		i2c@0 {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <0>;
>> +
>> +			eeprom@54 {
>> +				compatible = "at,24c08";
>> +				reg = <0x54>;
>> +			};
>> +		};
>> +	};
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e1b090f86e0d..3dd44d0d166c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5521,6 +5521,7 @@ S:	Maintained
>>   F:	Documentation/i2c/i2c-topology
>>   F:	Documentation/i2c/muxes/
>>   F:	Documentation/devicetree/bindings/i2c/i2c-mux*
>> +F:	Documentation/devicetree/bindings/i2c/i2c-arb*
>>   F:	drivers/i2c/i2c-mux.c
>>   F:	drivers/i2c/muxes/
>>   F:	include/linux/i2c-mux.h
>>
> 
