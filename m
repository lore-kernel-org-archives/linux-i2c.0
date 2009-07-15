From: "Karicheri, Muralidharan" <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
Date: Wed, 15 Jul 2009 10:35:40 -0500
Message-ID: <A69FA2915331DC488A831521EAE36FE40144E4C09D@dlee06.ent.ti.com>
References: <1246920516-31462-1-git-send-email-khilman@deeprootsystems.com>
	<20090707231938.GA9907@fluff.org.uk>
	<87skh79uai.fsf@deeprootsystems.com>
	<A69FA2915331DC488A831521EAE36FE40144D8117B@dlee06.ent.ti.com>
	<1247642943.5981.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1247642943.5981.76.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Philby,

That will be great! I will look for it.

Murali Karicheri
Software Design Engineer
Texas Instruments Inc.
Germantown, MD 20874
Phone : 301-515-3736
email: m-karicheri2-l0cyMroinI0@public.gmane.org

>-----Original Message-----
>From: Philby John [mailto:pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org]
>Sent: Wednesday, July 15, 2009 3:29 AM
>To: Karicheri, Muralidharan
>Cc: Kevin Hilman; Ben Dooks; davinci-linux-open-
>source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>Subject: RE: [PATCH 0/2] davinci i2c fixes for 2.6.31
>
>Hello Murali,
>
>	I will send a patch out to address this problem.
>
>Regards,
>Philby
>
>
>On Wed, 2009-07-08 at 10:25 -0500, Karicheri, Muralidharan wrote:
>> Hi Kevin,
>>
>> When we do a video loopback with MT9T031, we get i2c timeouts when
>application is killed using Cntrl C. Is it being addressed in any of the
>patches?  We had the same issue with TI LSP releases (1.20, 2.00, 2.1o etc=
).
>> The board has to be rebooted to recover from this.
>>
>> Murali Karicheri
>> Software Design Engineer
>> Texas Instruments Inc.
>> Germantown, MD 20874
>> Phone : 301-515-3736
>> email: m-karicheri2-l0cyMroinI0@public.gmane.org
>>
>> >-----Original Message-----
>> >From: davinci-linux-open-source-bounces+m-
>> >karicheri2=3Dti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org [mailto:davinci-linux-open-
>source-
>> >bounces+m-karicheri2=3Dti.com-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org] On Behalf Of Kevin
>Hilman
>> >Sent: Wednesday, July 08, 2009 9:30 AM
>> >To: Ben Dooks
>> >Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org; linux-
>> >i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >Subject: Re: [PATCH 0/2] davinci i2c fixes for 2.6.31
>> >
>> >Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> writes:
>> >
>> >> On Mon, Jul 06, 2009 at 03:48:34PM -0700, Kevin Hilman wrote:
>> >>> Here are a couple fixes for the i2c driver on the TI DaVinci family
>> >>> of SoCs.  These have been tested for awhile in the DaVinci git
>> >>> repo are needed for 2.6.31.
>> >>>
>> >>> These apply on v2.6.31-rc2.
>> >>
>> >> ok, do you have a git branch to pull, or should I apply
>> >> them from the mailing list>
>> >
>> >You can take from the list.  My git branch has a bunch of other
>> >non-i2c changes in it as well.
>> >
>> >Thanks,
>> >
>> >Kevin
>> >
>> >>> David Brownell (1):
>> >>>   i2c-davinci: behave with i2cdetect
>> >>>
>> >>> Kevin Hilman (1):
>> >>>   i2c-davinci: convert clock usage after clkdev conversion
>> >>>
>> >>>  drivers/i2c/busses/i2c-davinci.c |   20 +++++++++++++++-----
>> >>>  1 files changed, 15 insertions(+), 5 deletions(-)
>> >>>
>> >>> --
>> >>> To unsubscribe from this list: send the line "unsubscribe linux-i2c"
>in
>> >>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >> --
>> >> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
>> >>
>> >>   'a smiley only costs 4 bytes'
>> >
>> >_______________________________________________
>> >Davinci-linux-open-source mailing list
>> >Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> >http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>> _______________________________________________
>> Davinci-linux-open-source mailing list
>> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>
