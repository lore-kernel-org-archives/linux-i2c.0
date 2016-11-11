From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date: Fri, 11 Nov 2016 14:51:08 -0600
Message-ID: <2702c562-ca4a-b7e0-4828-85f0df7d8f9b@cavium.com>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore> <1595446.2T31j1Ekg5@np-p-burton>
 <20161111085707.GC16907@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20161111085707.GC16907@hardcore>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jan Glauber <jan.glauber@caviumnetworks.com>, Paul Burton <paul.burton@imgtec.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Peter Swain <pswain@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

On 11/11/2016 02:57 AM, Jan Glauber wrote:
> 
> we can reproduce the problem on our side, but I don't have direct access
> to a MIPS system so I'm still just guessing what happens. If you want
> you can try the attached patches.
> 
> I'm trying to get rid of the polling around the interrupt altogether.
> It works fine on Thunderx, sometimes I run into an interrupt timeout 
> after a lost-arbitration but recovery/retry is able to clean that up.
> 
> Please also revert 70121f7 as before. The last patch adds some debugging
> output to see if we run into timeouts or recovery.
> 
Using your three patches without reverting 70121f7 fails on both 71xx
and 78xx boards. Paul's "[PATCH 1/2] i2c: octeon: Fix register access"
eliminates the i2c probe hang and both boards boot properly. Tested
on top of Linus' v4.9-rc4 tag.

Steve
