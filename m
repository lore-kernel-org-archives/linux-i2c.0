From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c: mux: Add i2c-arb-gpio-challenge 'mux' driver
Date: Tue, 16 Apr 2013 09:25:26 -0700
Message-ID: <CAD=FV=WaRVP-imd2-es6101yaXf0P-hQktuJO_=MkuXZcVqp_A@mail.gmail.com>
References: <1363192583-26363-1-git-send-email-dianders@chromium.org>
 <1365543270-10736-1-git-send-email-dianders@chromium.org>
 <20130416093633.GC16978@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130416093633.GC16978-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd>
List-Id: linux-i2c@vger.kernel.org

Wolfram / Guenter / Stephen,

Thanks for your reviews.  New version on its way...

On Tue, Apr 16, 2013 at 2:36 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> "uses GPIO lines and a challange & response mechanism" or something like
> that. There might be other GPIO based arbitrations in the future (though
> I hope there won't).

Done (including fixing spelling of challenge).  Stephen: I think the
new paragraph is still high-level enough even with Wolfram's requested
addition.


>> +- their-claim-gpios: The GPIOs that the other sides use the claim the bus.
>> +  Note that some implementations may only support a single other master.
>
> Stronger? "Currently, only one other master is supported"?

As per Stephen Warren, I didn't touch this.  He says:

The DT binding documentation, which should be OS-/driver-agnostic,
should describe the binding, not the implementation. The limitation that
Linux imposes is OS-specific and hence should not be mentioned here as
an absolute, or perhaps even at all.

I think the current wording about "may only support a single other
master" is a compromise and would at least give some a clue that they
should check the Linux driver for details.


>> +       If you say yes to this option, support will be included for an
>> +       I2C multimaster arbitration scheme using GPIOs where masters have
>> +       to claim the bus by asserting a GPIO.
>
> "callenge & response"?

Done (including fixing spelling of challenge).


>> + * GPIO-based I2C Arbitration
>
> "callenge & response"?

Done (including fixing spelling of challenge).


>> +struct i2c_arbitrator_data {
>> +     struct i2c_adapter *parent;
>> +     struct i2c_adapter *child;
>> +
>
> No empty line.

Done.


>> +     int             our_gpio;
>> +     int             our_gpio_release;
>> +     int             their_gpio;
>> +     int             their_gpio_release;
>> +     unsigned int    slew_delay_us;
>> +     unsigned int    wait_retry_us;
>> +     unsigned int    wait_free_us;
>> +};
>
> Single space as indentaion after "int".

Done.
