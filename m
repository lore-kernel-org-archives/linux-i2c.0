From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4] i2c: davinci: Fix race when setting up for TX
Date: Wed, 22 Sep 2010 16:20:16 +0530
Message-ID: <45940.5690119185$1285153007@news.gmane.org>
References: <4C97CEC9.8060602@boundarydevices.com>
	<1285042408-13200-1-git-send-email-jon.povey@racelogic.co.uk>
	<4C9904E6.7070608@boundarydevices.com>
	<20100922000916.GH7494@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20100922000916.GH7494-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: 'Ben Dooks' <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, 'Troy Kisky' <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On Wed, Sep 22, 2010 at 05:39:16, Ben Dooks wrote:
> On Tue, Sep 21, 2010 at 12:17:58PM -0700, Troy Kisky wrote:
> > On 9/21/2010 4:24 AM, Sudhakar Rajashekhara wrote:
> > > Hi,
> > > 
> > > On Tue, Sep 21, 2010 at 09:43:28, Jon Povey wrote:
> > >> When setting up to transmit, a race exists between the ISR and
> > >> i2c_davinci_xfer_msg() trying to load the first byte and adjust counters.
> > >> This is mostly visible for transmits > 1 byte long.
> > >>
> > >> The hardware starts sending immediately that MDR.STT is set. IMR trickery
> > >> doesn't work because if we start sending, finish the first byte and an
> > >> XRDY event occurs before we load IMR to unmask it, we never get an
> > >> interrupt, and we timeout.
> > >>
> > >> Sudhakar Rajashekhara explains that at least OMAP-L138 requires MDR mode
> > >> settings before DXR for correct behaviour, so load MDR first with
> > >> STT cleared and later load again with STT set.
> > >>
> > >> Tested on DM355 connected to Techwell TW2836 and Wolfson WM8985
> > >>
> > >> Signed-off-by: Jon Povey <jon.povey-Ean/AyPsLtfkYMGBc/C6ZA@public.gmane.org>
> > >> CC: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > >> CC: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
> > >> ---
> > >> Reworked after comments by Troy and Sudhakar.
> > >>
> > >> Looking at the datasheet it seemed like setting STP without STT early
> > >> might cause a stray STOP to be generated, so I moved it into the second
> > >> MDR load.
> > >>
> > >> This passes a quick smoke test but I can't do much more testing right at
> > >> the moment. Sudhakar, your comments would be welcomed.
> > >>
> > > 
> > > Looks good to me. I can test on couple of platforms I have and update the result
> > > by tomorrow.
> > > 
> > > Thanks,
> > > Sudhakar
> > > 
> > > 
> > > 
> > I like it too. I hope it works for omap.
> > 
> > Thanks as well
> > Troy
> 
> Ok, any objections to this being applied, or should I wait?
> 

I am stuck in some other work. If you can wait till I test it, that'll
be good.

Thanks,
Sudhakar
