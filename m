From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 1/3] i2c: mux: Add i2c-arbitrator-cros-ec 'mux' driver
Date: Mon, 11 Mar 2013 09:05:33 -0700
Message-ID: <CAD=FV=UOeWaLDkycm40vGy3jPT8cPagr8WAjHG5Ukckd2+kTcw@mail.gmail.com>
References: <1360887677-20758-1-git-send-email-dianders@chromium.org>
	<1360957573-864-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360957573-864-1-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Prashanth G <prashanth.g-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TaqPxH82wqD4g@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Wolfram,

On Fri, Feb 15, 2013 at 11:46 AM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> The i2c-arbitrator-cros-ec driver implements the arbitration scheme
> that the Embedded Controller (EC) on the ARM Chromebook expects to use
> for bus multimastering.  This i2c-arbitrator-cros-ec driver could also
> be used in other places where standard I2C bus arbitration can't be
> used and two extra GPIOs are available for arbitration.
>
> This driver is based on code that Simon Glass added to the i2c-s3c2410
> driver in the Chrome OS kernel 3.4 tree.  The current incarnation as a
> mux driver is as suggested by Grant Likely.  See
> <https://patchwork.kernel.org/patch/1877311/> for some history.
>
> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
> Changes in v3:
> - Handle of_find_i2c_adapter_by_node() failure more properly by
>   changing init order.
> - Don't warn on -EPROBE_DEFER from calls that could return it.
> - Move to module_platform_driver().  As we pull in parts of the system
>   that rely on devices under this i2c bus we'll need to make sure they
>   can handle the fact that they'll be initted later now.
>
> Changes in v2:
> - Renamed to i2c-arbitrator-cros-ec.
> - Documented "microsecond" properties as optional; removed
>   "bus-arbitration" prefix since it was just extra wordy.
> - Split GPIOs into two properties to make it cleaner.
> - Capitalized I2C in freeform text.
> - Get 'active low' from device tree.
>
>  .../bindings/i2c/i2c-arbitrator-cros-ec.txt        |  76 +++++++
>  drivers/i2c/muxes/Kconfig                          |  11 +
>  drivers/i2c/muxes/Makefile                         |   2 +
>  drivers/i2c/muxes/i2c-arbitrator-cros-ec.c         | 222 +++++++++++++++++++++
>  4 files changed, 311 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arbitrator-cros-ec.txt
>  create mode 100644 drivers/i2c/muxes/i2c-arbitrator-cros-ec.c

Is there anything you'd like done before landing this patch for 3.10?
It's been reviewed by Stephen Warren (thanks Stephen!).  From what I
remember from Olof's talk at ELC it seems like the best thing would be
to merge part 1 through i2c tree and then ask Olof to merge parts 2
and 3 (the dts bits) through the arm-soc tree.

I believe you could also add a "Tested-by" from Naveen to patch #1.
He sent a tested by for parts 2 and 3 so must have also tested part 1
(the other two don't function without it).

Please let me know--I'm happy to spin with any changes needed.  :)

-Doug
