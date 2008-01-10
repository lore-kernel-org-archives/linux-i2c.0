From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: i2c-remove-redundant-i2c_client-list.patch
Date: Thu, 10 Jan 2008 14:31:05 +0100
Message-ID: <20080110143105.456ddaf0@hyperion.delvare>
References: <20071216052308.A0FB11668D7@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20080109142906.23a55f5f@hyperion.delvare>
	<20080109171934.4f894bdc@hyperion.delvare>
	<200801091321.29212.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200801091321.29212.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Jan 2008 13:21:28 -0800, David Brownell wrote:
> Right now I'm thinking that we'll need a multi-phase approach:
> 
> (a) Start phasing out users of i2c_client.list and its lock, ASAP;
>     merging those DVB driver patches, and some i2c-core changes.

Fine with me. Can you please send the i2c-core patch? It would include
i2c_verify_client(), then I can deal with the V4L drivers patch and
these 2 patches can be pushed to -mm quickly.

> (b) But don't remove that list from the deletion path until ...
> 
> (c) ... We have a solution that removes that wait_for_completion()
>     and its infrastructure.  (Note the similar i2c_adapter logic
>     too, sigh.)
> 
> (d) Meanwhile, come up with a different solution to the deadlock
>     observed with i2c_adapter.clist ... which for some unknown
>     reason has *NOT* shown up for me with lockdep.
> 
> Of course, if (c) happens soon soon, this problem simplifies.  And
> maybe someone will come up with a non-invasive solution to that
> problem ... but if nobody does so before, say, Monday, I'm thinking
> that (d) becomes a priority.

I won't be able to help with this as I don't understand it fully,
sorry. But I can do any amount of testing if someone sends patches.

-- 
Jean Delvare
