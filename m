From: Peter Rosin <peda@axentia.se>
Subject: Re: nested I2C muxes
Date: Thu, 19 Jan 2017 23:50:52 +0100
Message-ID: <ddbc9c2d-c1f4-0858-4453-bb03777ab236@axentia.se>
References: <595ed81b-546b-a60f-1bf1-b21f14c15b3c@cern.ch>
 <693bca75-e610-a96e-45d8-06af861500a9@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr10114.outbound.protection.outlook.com ([40.107.1.114]:63520
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751960AbdASWvC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 19 Jan 2017 17:51:02 -0500
In-Reply-To: <693bca75-e610-a96e-45d8-06af861500a9@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Adrian Fiergolski <Adrian.Fiergolski@cern.ch>, linux-i2c@vger.kernel.org

On 2017-01-19 19:34, Peter Rosin wrote:
> On 2017-01-19 19:03, Adrian Fiergolski wrote:
>> Hi,
>>
>> I haven't found any information regarding support for nested i2c muxes.
>> Is the below device tree supported by the current driver ?
> 
> No, it is not since you cannot have two devices with address 0x74
> visible at the same time. You would have to set a different address
> on one of the muxes using its A0-A2 pins. Then it should work.
> 
> Look in Documentation/i2c/i2c-topology for more information.
> 
> Cheers,
> peda
> 
>> &i2c0 {
>>         status = "okay";
>>         clock-frequency = <400000>;
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&pinctrl_i2c0_default>;
>>
>>         i2cswitch@74 {
>>                 compatible = "nxp,pca9548";
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>                 reg = <0x74>;
>>
>>                 i2c@0 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         reg = <0>;
>>                         si570: clock-generator@5d {
>>                                 #clock-cells = <0>;
>>                                 compatible = "silabs,si570";
>>                                 temperature-stability = <50>;
>>                                 reg = <0x5d>;
>>                                 factory-fout = <156250000>;
>>                                 clock-frequency = <148500000>;
>>                         };
>>                 };
>>
>>                 i2c@2 {
>>                         #address-cells = <1>;
>>                         #size-cells = <0>;
>>                         reg = <5>;

Also, this <5> is bogus. It should match the @2 a few lines up.

Cheers,
peda

>>                         i2cswitch_hpc@74 {
>>                                 compatible = "nxp,pca9548";
>>                                 #address-cells = <1>;
>>                                 #size-cells = <0>;
>>                                 reg = <0x74>;
>>                                 hpc_caribou_sources_enable@76  {
>>                                         compatible= "nxp,pca9539";
>>                                         #address-cells = <1>;
>>                                         #size-cells = <0>;
>>                                         reg = <0x76>;
>>                                 };
>>                         };
>>
>>                 };
>>
>>         };
>>
>> };
>>
>> With such tree I am getting error
>>
>> [2.173385] i2c i2c-2: of_i2c: invalid addr=0 on
>> /amba/i2c@e0004000/i2cswitch@74/i2c@2/i2cswitch_hpc@74
>>
>>
>> Regards,
>>
>> Adrian Fiergolski
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
