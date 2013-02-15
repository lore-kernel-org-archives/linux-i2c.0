From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v2 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Fri, 15 Feb 2013 10:38:29 -0700
Message-ID: <511E7295.4000902@wwwdotorg.org>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
 <511E64C0.9090500@wwwdotorg.org>
 <CAD=FV=W9WwSsid_KqtDRmAkFXnneRXu5zcakDB3t4hLhOpuCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=W9WwSsid_KqtDRmAkFXnneRXu5zcakDB3t4hLhOpuCtw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter Korsgaard <peter.ko>
List-Id: linux-i2c@vger.kernel.org

On 02/15/2013 10:25 AM, Doug Anderson wrote:
> Stephen,
> 
> New version will come shortly with fixes below...
> 
> 
> On Fri, Feb 15, 2013 at 8:39 AM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> On 02/14/2013 05:21 PM, Doug Anderson wrote:
>>> The i2c-arbitrator-cros-ec driver implements the arbitration scheme
>>> that the Embedded Controller (EC) on the ARM Chromebook expects to use
>>> for bus multimastering.  This i2c-arbitrator-cros-ec driver could also
>>> be used in other places where standard I2C bus arbitration can't be
>>> used and two extra GPIOs are available for arbitration.
...
>>> +subsys_initcall(i2c_arbitrator_init);
>>
>> You mentioned that you only saw problems using
>> module_init/module_platform_driver in your downstream tree, so the
>> problem doesn't affect upstream. Presumably those problems would be
>> fixed when upstreaming any other drivers into the mainline kernel. I'd
>> still be tempted to just use module_platform_driver here. But, I guess
>> I'm fine with the patch either way; I'll leave the call to Wolfram.
> 
> I take it you thought my "since this provides a bus it should be a
> subsystem" argument was BS?

I think subsystem and bus are different things. A driver for a specific
device provides a bus, and happens to use the facilities (or be part of)
a specific subsystem. Generally the subsystem isn't actually the bus
itself (although perhaps something like PCI could be an exception).

Admittedly I have no history/experience really with what the different
initcall levels are really intended for, but my suspicion is that
subsys_initcall is intended for whole subsystems to initialize their
infra-structure before handling drivers or serving requests out to other
code. But, who knows.

Either way though, I believe that upstream, no driver should be relying
on specific initcall levels in order to get dependencies/initialization
ordering correct.
