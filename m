From: Stefan Richter <stefanr-MtYdepGKPcBMYopoZt5u/LNAH6kLmebB@public.gmane.org>
Subject: Re: Problem with restricted I2C algorithms in kernel 2.6.26!
Date: Fri, 08 Aug 2008 02:17:52 +0200
Message-ID: <489B90B0.5070303@s5r6.in-berlin.de>
References: <489B6A66.40605@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <489B6A66.40605-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
Cc: user.kernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

mkrufky-dJidKbW2IEtAfugRpC6u6w@public.gmane.org wrote:
> With the model that you propose, "use linux-next for development" ... 
> well then what about testing?  Who is going to test my driver if it 
> requires a full kernel compile?

We almost _never_ use linux-next in the way that we base our development 
on it.  We use it to prepare integration.


BTW, looking back at this thread in the list archive, I see some people 
thoroughly confusing
   - unmerged code,
   - external developer repositories/ external patchkits,
   - module source files outside a complete kernel source directory.
These are all independent matters.

All code starts as unmerged code.
All developers use external repositories.

However, module source files which are outside of the kernel source 
directory are not quite the norm.  (Because the kernel build system 
doesn't support this.)
-- 
Stefan Richter
-=====-==--- =--- -=---
http://arcgraph.de/sr/

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
