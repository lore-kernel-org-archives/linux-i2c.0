From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Mon, 28 Nov 2016 08:47:28 -0600
Message-ID: <10e3f92d-2f8b-0862-1029-e9617d770f73@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
 <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
 <20161122120106.GB3993@katana> <20161122145539.GA7716@hardcore>
 <20161128142208.GA3916@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20161128142208.GA3916@katana>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Wolfram Sang <wsa-dev@sang-engineering.com>, Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On 11/28/2016 08:22 AM, Wolfram Sang wrote:
> 
>>>> This does not work on Octeon 71xx platforms. I will look at it more
>>>> closely tomorrow.
>>>
>>> What's the outcome here? It seems we want a bugfix for 4.9 but this
>>> report keeps me reluctant to apply the series.
>>>
>>
>> Steven, did you have a chance to check which of the patches makes
>> Octeon 71xx fail?
> 
> How do we proceed with this one? Is somebody at Cavium able to contact
> Steven internally? I mentioned this on-going regression to Linus and
> said an rc8 would help us, but reading LWN it seems we shouldn't count
> on it...
> 
I will finish the bisecting today and will let you know as soon as
the bug is found.

Steve
