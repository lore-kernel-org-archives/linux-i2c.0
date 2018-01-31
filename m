From: Corey Minyard <minyard@acm.org>
Subject: Re: Please pick up i2c-xlp9xx driver patches
Date: Wed, 31 Jan 2018 15:41:15 -0600
Message-ID: <2dc0cbda-2e49-7e10-c619-c69fb4aef061@acm.org>
References: <CAAek22FfKtt3QzXjcR1WatkFvLuTO5QWSKqCmE7mUGzTG0tZFQ@mail.gmail.com>
 <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
In-Reply-To: <CAAek22EEs_mHcKg80Ei=FRNH88KVjWJNHHVZ3cU204c0fW8v2w@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
 <mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Phil Pokorny <ppokorny@penguincomputing.com>, openipmi-developer@lists.sourceforge.net, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 01/31/2018 03:06 PM, Phil Pokorny wrote:
> Cross-posting to openipmi and linux-i2c... (in plain text this time...
> my apologies.)
> There are four patches from Cavium starting with
> https://lkml.org/lkml/2018/1/18/12 that fix an issue with the xlp9xx
> driver that causes ipmi_ssif not to be able to detect a platform BMC.
>
> I have two different pre-production hardware chassis that are affected
> by this issue and I don't see that the patches were included in v4.15.
>
> I wonder if either Corey or Jean could/should pick these up and submit
> upstream?

It is all I2C changes, so it's outside my realm.

-corey

>   There doesn't seem to be a MAINTAINERS entry for the
> i2c-xlp9xx  The driver was submitted Cavium (was Broadcom at the time)
>   The posts don't seem to have gotten any comments on LKML.
>
> I tested the patches and they fix the ipmi_ssif detection issue I had.
> So I'm willing to add "Tested-by" to the patches if that helps.
>
> Would like to see these patches make it up-stream so I can they ask
> that they be included in the Red Hat and SuSE distro kernels for
> ARM64.
>
> Thanks,
> Phil P.
>
> --
> Philip Pokorny, RHCE
> Chief Technology Officer
> PENGUIN COMPUTING, Inc
> www.penguincomputing.com
>
> Changing the world through technical innovation
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
