From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/4] i2c: fix i2c adapter device driver user counter
Date: Sun, 02 Aug 2015 02:37:06 +0300
Message-ID: <55BD5822.6000806@mleia.com>
References: <1438007451-8553-1-git-send-email-vladimir_zapolskiy@mentor.com> <20150801100929.GA4379@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150801100929.GA4379@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 01.08.2015 13:09, Wolfram Sang wrote:
> On Mon, Jul 27, 2015 at 05:30:47PM +0300, Vladimir Zapolskiy wrote:
>> The series fixes i2c bus device refcounting for clients of i2c_get_adapter(),
>> of_find_i2c_adapter_by_node() and of_find_i2c_device_by_node() interfaces.
> 
> Yay, thanks for working on that!
> 
>> The v2 3/4 change adds and exports new of_get_i2c_adapter_by_node()
>> interface of i2c core, v2 4/4 is an unchanged version of v1 10/10, which
>> utilizes this new interface in order to fix the refcounting bug described
>> below in detail.
> 
> And thanks for the good descriptions, too.
> 
>> To fix existing users of these interfaces and to avoid any further
>> confusion and misusage in future, add one more interface
>> of_get_i2c_adapter_by_node(), it is similar to i2c_get_adapter() in
>> sense that an I2C bus device driver found and locked by user can be
>> correctly unlocked by i2c_put_adapter().
> 
> I tend to agree to the idea of the new function, should be less error
> prone to users. Need to think about it a day more, though.
> 
>> Changes from v1 to v2:
>> * added two more patches 1/4 and 2/4 fixing i2c bus device refcounting,
>>   thanks to Thierry for the idea of 2/4 change,
> 
> I'll apply 1/4 to for-current, since this is a clear bugfix. 2/4 seems
> very worthwhile, too, but seems like less a bugfix to me; while it
> changes things to be more correct, it also is a preparation for the
> following patches.
> 
>> * defer changes in 8 broken DRM and fbdev clients until i2c-core changes
>>   are added to linux-next (or preferably 4.2.0-rc Linus' branch, if possible)
>>   to improve signal/noise ratio on mailing lists.
> 
> That was a clever thing to do. However, my gut feeling is that these
> changes to refcounting behaviour should go via the next merge window to
> get proper testing. If you guys want that in 4.2, then I would need a
> lot of Tested, Acked, and Reviewed-by tags very soon.
> 

thank you for review, I'm fine if the rest of the changes enters
linux-next, after that, when drm-next picks them up, I'll send fixes to
the clients.

--
With best wishes,
Vladimir
