From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: Cleaning and comment style fixes.
Date: Tue, 13 Dec 2016 19:00:28 +0200
Message-ID: <1481648428.8991.4.camel@linux.intel.com>
References: <32604e59cde19a8981681ad2f0ee447af847bf60.1481646098.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <32604e59cde19a8981681ad2f0ee447af847bf60.1481646098.git.lolivei-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2016-12-13 at 16:34 +0000, Luis Oliveira wrote:
> - Misspelling of some words

So, do you use codespell tool for that? I would suggest to use that tool
and propose any fix there first. At least that tool has a good history
of changes back in forward until some native speaker(s) settle some
cases.

> - Comment format fix

No need to use dot at the end of one-liner comments

/* One line */

/*
 * Multi-line comments. Might include several lines or
 * even paragraphs.
 */

Also I would leave 
/*
 * One line
 */

Without dots here. AFAIU they are used to better distinguish group of
definitions inside headers (that's why 3 lines).

> - Minor fix in coding style
> 

I'm almost fine with the change itself, but people may be concerned in:

1) what is the value of the change (would be nice to put this in commit
message);

2) how much additional work this change may bring for backported fixes
if any;

3) native speakers are the best who can re-read this and Ack.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
