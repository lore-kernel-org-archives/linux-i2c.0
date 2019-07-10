From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: Re: [RFC] SW connection between DVB Transport Stream demuxer and
 I2C-based frontend
Date: Wed, 10 Jul 2019 15:52:07 +0200
Message-ID: <12b7118b-5118-cc43-2d0b-aff9650914a5@free.fr>
References: <5e35b4fb-646d-6428-f372-ee47d7352cd6@free.fr>
 <7d47a978-5307-a2c8-acc2-f29ce7567bd5@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7d47a978-5307-a2c8-acc2-f29ce7567bd5@axentia.se>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>, I2C <linux-i2c@vger.kernel.org>, linux-media <linux-media@vger.kernel.org>, GPIO <linux-gpio@vger.kernel.org>
Cc: Peter Korsgaard <peter@korsgaard.com>, Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Brad Love <brad@nextdimension.cc>, =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>, Bjorn Andersson <bjorn.andersson@linaro.org>, Antti Palosaari <crope@iki.fi>, Simon Horman <horms+renesas@verge.net.au>, Mauro Carvalho Chehab <mchehab@kernel.org>, Olli Salonen <olli.salonen@iki.fi>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On 08/07/2019 21:58, Peter Rosin wrote:

> On 2019-07-08 13:08, Marc Gonzalez wrote:
> 
>> PROBLEM #2
>>
>> The tuner (si2157) is not on the i2c5 bus, instead it is on a private
>> i2c bus *behind* si2168, which routes requests to the proper client.
>> For the time being, I don't know how to model this relationship in DT.
>> (TODO: check i2c_slave_cb_t slave_cb in struct i2c_client)
>> I have initialized si2157 in the si2168 driver, but this doesn't feel
>> right. (Though it seems all(?) users pair 2168 with 2157.)
>>
>>
>> diff --git a/arch/arm64/boot/dts/qcom/apq8098-batfish.dts b/arch/arm64/boot/dts/qcom/apq8098-batfish.dts
>> index 29d59ecad138..9353e62375a7 100644
>> --- a/arch/arm64/boot/dts/qcom/apq8098-batfish.dts
>> +++ b/arch/arm64/boot/dts/qcom/apq8098-batfish.dts
>> @@ -30,6 +30,28 @@
>>  	status = "ok";
>>  };
>>  
>> +&blsp1_i2c5 {
>> +	status = "ok";
>> +	clock-frequency = <100000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&i2c5_default>;
>> +
>> +	dvb_demod: si2168@64 {
>> +		compatible = "silabs,si2168";
>> +		reg = <0x64>;
>> +		reset-gpios = <&tlmm 84 GPIO_ACTIVE_LOW>;
> 
> 
> In principle, I think you should be able to add something like this here:
> 
> 		i2c-gate {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			tuner@60 {
> 				compatible = "silabs,si2157";
> 				reg = <0x60>;
> 				/* whatever else is needed */
> 			};
> 		};
> 
> But in practice, I don't know if the si2157 driver understands that or
> if there is anything else that gets in the way. Totally untested...
> 
> The i2c-gate child node is examined when you call i2c_mux_add_adapter
> if you have provided the correct struct device in the second argument
> when you called i2c_mux_alloc (I think that is already the case). You
> also need to set the I2C_MUX_GATE flag in the i2c_mux_alloc call, but
> I do not see a problem with that since I think only one child adapter
> is added. If it is a problem to add the I2C_MUX_GATE flag, then you
> can just adjust the above i2c-gate node according to the bindings in
> Documentation/devicetree/bindings/i2c/i2c-mux.txt. I.e. add this
> instead of the above i2c-gate node:
> 
> 		i2c-mux {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 
> 			i2c@0 {
> 	                        #address-cells = <1>;
>         	                #size-cells = <0>;
>                 	        reg = <0>;
> 
> 				tuner@60 {
> 					compatible = "silabs,si2157";
> 					reg = <0x60>;
> 					/* whatever else is needed */
> 				};
> 			};
> 		};
> 
> But it feels *right* to add the I2C_MUX_GATE flag, because a gate is
> what you have. I think?

Thanks, Peter!

Your solution works great. It's refreshing to have stuff work
out-of-the-box!

Problem #2 is now taken care of. And Brad proposed an elegant
solution (IMO) for Problem #1.

I'll send an updated RFC v2 tomorrow. (My patch series is a
complete mess right now.)

Regards.
