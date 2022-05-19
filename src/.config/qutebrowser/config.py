# Make tab-switching bindings make more sense to me: j=left, k=right
config.unbind('K', mode='normal')
config.unbind('J', mode='normal')
config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')

c.scrolling.smooth = True
