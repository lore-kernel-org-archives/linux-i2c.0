From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v6 4/9] dt-bindings: iio: iio-mux: document iio-mux
 bindings
Date: Tue, 6 Dec 2016 10:18:53 +0100
Message-ID: <ea58cfe1-88ed-f215-59df-e9ffba485eaa@axentia.se>
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-5-git-send-email-peda@axentia.se>
 <20161205232624.5wjvmchd6jxd24ir@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161205232624.5wjvmchd6jxd24ir@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2016-12-06 00:26, Rob Herring wrote:
> On Wed, Nov 30, 2016 at 09:16:58AM +0100, Peter Rosin wrote:
>> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
>> ---
>>  .../bindings/iio/multiplexer/iio-mux.txt           | 40 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  6 ++++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
> 
> I'm still not convinced about this binding, but don't really have more 
> comments ATM. Sending 6 versions in 2 weeks or so doesn't really help 
> either.

Sorry about the noise, I'll try to be more careful going forward. On
the flip side, I haven't touched the code since v6.

I don't see how bindings that are as flexible as the current (and
original) phandle link between the mux consumer and the mux controller
would look, and at the same time be simpler to understand. You need
to be able to refer to a mux controller from several mux consumers, and
you need to support several mux controllers in one node (the ADG792A
case). And, AFAICT, the complex case wasn't really the problem, it was
that it is overly complex to describe the simple case of one mux
consumer and one mux controller. But in your comment for v2 [1] you
said that I was working around limitations with shared GPIO pins. But
solving that in the GPIO subsystem would not solve all that the
phandle approach is solving, since you would not have support for
ADG792A (or other non-GPIO controlled muxes). So, I think listing
the gpio pins inside the mux consumer node is a non-starter, the mux
controller has to live in its own node with its own compatible.

Would you be happier if I managed to marry the phandle approach with
the option of having the mux controller as a child node of the mux
consumer for the simple case?

I added an example at the end of this message (the same as the first
example in v4 [2], at least in principle) for easy comparison between
the phandle and the controller-in-child-node approaches. I can't say
that I personally find the difference all that significant, and do not
think it is worth it. As I see it, the "simple option" would just muddy
the waters...

[1] http://marc.info/?l=linux-kernel&m=147948334204795&w=2
[2] http://marc.info/?l=linux-kernel&m=148001364904240&w=2

>> diff --git a/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
>> new file mode 100644
>> index 000000000000..8080cf790d82
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/multiplexer/iio-mux.txt
>> @@ -0,0 +1,40 @@
>> +IIO multiplexer bindings
>> +
>> +If a multiplexer is used to select which hardware signal is fed to
>> +e.g. an ADC channel, these bindings describe that situation.
>> +
>> +Required properties:
>> +- compatible : "iio-mux"
> 
> This is a Linuxism. perhaps "adc-mux".

No, that's not general enough, it could just as well be used to mux a
temperature sensor. Or whatever. Hmmm, given that "iio-mux" is bad, perhaps
"io-channel-mux" is better? That matches the io-channels property used to
refer to the parent channel.

>> +- io-channels : Channel node of the parent channel that has multiplexed
>> +		input.
>> +- io-channel-names : Should be "parent".
>> +- #address-cells = <1>;
>> +- #size-cells = <0>;
>> +- mux-controls : Mux controller node to use for operating the mux
>> +- channels : List of strings, labeling the mux controller states.
>> +
>> +The multiplexer state as described in ../misc/mux-controller.txt
>> +
>> +For each non-empty string in the channels property, an iio channel will
>> +be created. The number of this iio channel is the same as the index into
>> +the list of strings in the channels property, and also matches the mux
>> +controller state.
>> +
>> +Example:
>> +	mux: mux-controller {
>> +		compatible = "mux-gpio";
>> +		#mux-control-cells = <0>;
>> +
>> +		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
>> +			    <&pioA 1 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	adc-mux {
>> +		compatible = "iio-mux";
>> +		io-channels = <&adc 0>;
>> +		io-channel-names = "parent";
>> +
>> +		mux-controls = <&mux>;
>> +
>> +		channels = "sync", "in", system-regulator";
>> +	};

Describing the same as above, but with the mux controller as a child
node.

	adc-mux {
		compatible = "iio-mux";
		io-channels = <&adc 0>;
		io-channel-names = "parent";

		channels = "sync", "in", system-regulator";

		mux-controller {
			compatible = "mux-gpio";

			mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
				    <&pioA 1 GPIO_ACTIVE_HIGH>;
		};
	};

Cheers,
Peter

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
