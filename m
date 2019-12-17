From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Date: Tue, 17 Dec 2019 13:08:03 +0530
Message-ID: <CAKfKVtHG3eArV9Fd1a1UqqbP4e1Tz_ZeBrJJKfwMoP=c2PNqfA@mail.gmail.com>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
 <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
 <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
 <20171207104915.fdqkj35ga2yxeg3n@ninjato>
 <CAFcVECKVR5fmVipB1cN97COecULcHtJFrediTsriSuwrm_A_Nw@mail.gmail.com>
 <CA+Y=x3nZsfJ+hE5YjvYLM0tdaRX9hX1G6crAjOmmnks-9Rekqg@mail.gmail.com>
 <CA+Y=x3=NXpwmqk9RR4oZVkndo=kFwG5T39ktHAhFb=Q9m61Mjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Y=x3=NXpwmqk9RR4oZVkndo=kFwG5T39ktHAhFb=Q9m61Mjg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Worsley <amworsley@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>, Harini Katakam <harinikatakamlinux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Andrew,
Apologies for the late reply.

On Thu, Jan 18, 2018 at 7:53 AM Andrew Worsley <amworsley@gmail.com> wrote:
>
> On 8 December 2017 at 09:15, Andrew Worsley <amworsley@gmail.com> wrote:
> > Thanks. I regularly see the warning my patch prints out  on boot up as then
> > there is a big pull of random data from the TPM.
>
>    Just an update on this bug - I did a i2c capture with pulseview on
> a boot that included this issue.
>
> > On 8 Dec 2017 12:30 am, "Harini Katakam" <harinikatakamlinux@gmail.com>
> > wrote:
> >>
> >> Hi Wolfram and Andrew,
> >>
> >> On Thu, Dec 7, 2017 at 4:19 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> >
> >> >> > I attach a patch of the changes to the i2c driver showing my debug in
> >> >> > this driver.
> >> >> > As I said I am happy to send more verbose bug output - I have about
> >> >> > 36
> >> >> > odd runs with 9 occurences of the bug.
> >> >> > Once it happen twice in the one run
> >> >> >
> >> >> > I include the crashing line from the runs where the bug occured (I
> >> >> > added more diagnostics as the runs progressed):
> >> >>
> >> >> I'll check with out HW team as well and check your flow to
> >> >> see if we can reproduce it; will also check if the existing errata
> >> >> has larger scope.
> >> >> I'll let you know if we require further assistance with debug
> >> >> next week.
> >> >
> >> > Any news here?
> >>
> >> Sorry for the delay.
> >> I've checked the known errata and confirmed that it wont
> >> affect this use case. And we haven't been able to hit this
> >> issue on our HW (with eeprom slave devices).
> >> I will add my colleague looking into this further to debug.
> >>
> >> Regards,
> >> Harini
>
> I suspect a well behaved i2c slave may never show the issue. But the
> i2c cadence doesn't handle bad slaves safely
> so I suggest that length check is needed to avoid buffer kernel
> crashes due to mis-behaving i2c hardware.
>
> I got a board that this issue was *very* bad to the point that the
> TPM_RANDOM requests repeatedly returned the same data and so were
> failing the sanity tests. So I captured the i2c transactions using
> pulseview and very bad behaviour from the TPM. The problem disappears
> at 100KHz and very reliably occurs at 400k on this individual board so
> I believe this TPM is failing to keep up with the i2c clock and
> screwying everything up.
>
> What I am concerned about is that the i2c-cadence driver is almost
> always carrying on and returning data with out errors.
>
I agree we should attempt to fix this could  you resend the patch
removing the debug.

thanks and Regards,
Shubhrajyoti
