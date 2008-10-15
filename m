From: Michael Krufky <mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 2/6]: i2c-pcf: Add adapter hooks around xfer begin
 and end.
Date: Wed, 15 Oct 2008 17:37:41 -0400
Message-ID: <48F662A5.4050303@linuxtv.org>
References: <20080821.024322.35962617.davem@davemloft.net>
	<20081015141914.7d6c3dd5@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20081015141914.7d6c3dd5-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> Hi David,
>
> On Thu, 21 Aug 2008 02:43:22 -0700 (PDT), David Miller wrote:
>   
>> i2c-pcf: Add adapter hooks around xfer begin and end.
>>
>> Some I2C bus implementations need to synchronize with external
>> entities, such as system firmware, which might also be programming the
>> same I2C bus.
>>
>> In order to facilitate this add ->xfer_begin() and ->xfer_end() hooks
>> which are invoked around pcf_xfer().
>>     
>
> I get the idea, but I'm not sure about the implementation. I had a
> request several months ago for something similar for the i2c-algo-bit
> driver. I don't think we want to duplicate this mechanism in every
> i2c-algo driver, so it would probably make sense to implement it
> at the i2c-core level?
>
> Michael, do you still need this for i2c-algo-bit? We did not discuss
> this again recently, so I admit I don't know what is the status of this
> request.

Jean,

Yes, the problem still exists, and I still need a way to lock the i2c 
adapter during certain volitile operations at driver start-up.

Right now I have an artificial delay in place as a workaround, but 
that's only because there currently is no other choice.

Basically, I have a single piece of silicon that is capable of bringing 
down the entire i2c bus if somebody attempts to communicate with any 
other IC during initialization of this silicon.

Regards,

Mike

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
