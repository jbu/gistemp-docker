from distutils.core import setup, Extension

module1 = Extension('stationstring', 
			sources = ['stationstringmodule.c'])

setup (name = 'stationstring', 
	version = '1.0', 
	description = 'This is a demo package', 
	ext_modules = [module1])

