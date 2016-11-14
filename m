From: "Steven J. Hill" <Steven.Hill@cavium.com>
Subject: Re: [PATCH v2 0/3] i2c: octeon: thunder: Fix i2c not working on
 Octeon
Date: Mon, 14 Nov 2016 13:53:40 -0600
Message-ID: <99500824-4c63-b769-ad66-c136529b14b2@cavium.com>
References: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1479149445-4663-1-git-send-email-jglauber@cavium.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Jan Glauber <jglauber@cavium.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, Paul Burton <paul.burton@imgtec.com>, David Daney <david.daney@cavium.com>
List-Id: linux-i2c@vger.kernel.org

On 11/14/2016 12:50 PM, Jan Glauber wrote:
> 
> Since time is running out for 4.9 (or might have already if you're not
> going to send another pull request) I'm going for the safe option
> to fix the Octeon i2c problems, which is:
> 
> 1. Reverting the readq_poll_timeout patch since it is broken
> 2. Apply Patch #2 from Paul
> 3. Add a small fix for the recovery that makes Paul's patch
>    work on ThunderX
> 
> I'll try to come up with a better solution for 4.10. My plan is to get rid
> of the polling-around-interrupt thing completely, but for that we need more
> time to make it work on Octeon.
> 
> Please consider for 4.9.
> 
Hey Jan.

This does not work on Octeon 71xx platforms. I will look at it more
closely tomorrow.

Steve
