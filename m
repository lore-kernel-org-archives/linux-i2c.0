From: sathyanarayanan kuppuswamy
	<sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 1/1] i2c: Add acpi support to enumerate i2c mux clients
Date: Mon, 18 May 2015 13:52:11 -0700
Message-ID: <555A50FB.9040900@linux.intel.com>
References: <cover.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com> <b57c66fc1b7e790bd8c3e525faf65ce46cd91f23.1428546834.git.sathyanarayanan.kuppuswamy@linux.intel.com> <20150410084208.GR1734@lahna.fi.intel.com>
Reply-To: sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150410084208.GR1734-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

gentle ping.

On 04/10/2015 01:42 AM, Mika Westerberg wrote:
> On Thu, Apr 09, 2015 at 12:15:42PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Added support to enumerate i2c mux clients via ACPI.
>>
>> Currently we don't have any fixed way for enumerating
>> mux clients via acpi. This patch adds support to scan
>> for all client i2c devices under the mux device in DSDT
>> table and enumerate them in order.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >From ACPI standpoint I don't see problems with this code.
>
> Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
