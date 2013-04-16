From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c: mux: Add i2c-arb-gpio-challenge 'mux' driver
Date: Tue, 16 Apr 2013 09:42:14 -0600
Message-ID: <516D7156.3050807@wwwdotorg.org>
References: <1363192583-26363-1-git-send-email-dianders@chromium.org> <1365543270-10736-1-git-send-email-dianders@chromium.org> <20130416093633.GC16978@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130416093633.GC16978-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 04/16/2013 03:36 AM, Wolfram Sang wrote:
> Doug,
> 
> On Tue, Apr 09, 2013 at 02:34:28PM -0700, Doug Anderson wrote:
>> The i2c-arb-gpio-challenge driver implements an I2C arbitration scheme
>> where masters need to claim the bus with a GPIO before they can start
>> a transcation.  This should generally only be used when standard I2C
>> multimaster isn't appropriate for some reason (errata/bugs).
>>
>> This driver is based on code that Simon Glass added to the i2c-s3c2410
>> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
>> mux driver is as suggested by Grant Likely.  See
>> <https://patchwork.kernel.org/patch/1877311/> for some history.

>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt b/Documentation/devicetree/bindings/i2c/i2c-arb-gpio-challenge.txt

>> +GPIO-based I2C Arbitration
>> +==========================
>> +This uses GPIO lines to arbitrate who is the master of an I2C bus in a
>> +multimaster situation.
> 
> "uses GPIO lines and a challange & response mechanism" or something like
> that. There might be other GPIO based arbitrations in the future (though
> I hope there won't).

The existing text appears clearer to me; this document should spell out
the exact details of the protocol in later paragraphs, so there's no
need to try and spell it out here.

>> +- their-claim-gpios: The GPIOs that the other sides use the claim the bus.
>> +  Note that some implementations may only support a single other master.
> 
> Stronger? "Currently, only one other master is supported"?

The DT binding documentation, which should be OS-/driver-agnostic,
should describe the binding, not the implementation. The limitation that
Linux imposes is OS-specific and hence should not be mentioned here as
an absolute, or perhaps even at all.
