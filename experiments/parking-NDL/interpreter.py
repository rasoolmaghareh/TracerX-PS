import re


def ndl_to_data(filename):
    with open(filename, "r") as ndl:
        content = ndl.read().replace('\n', ' ')
        match_types = re.findall("type\s*(.*?)\s*=\s*{\s*(.*?)\s*}\s*;", content)
        match_declares = re.findall("decl\s*(.*?)\s*\[\s*(.*?)\s*]\s*:\s*(.*?)\s*\s*;", content)
        match_initial = re.findall("initial\s*(.*?)\s*goal", content)[0].split(';')
        match_goal = re.findall("goal\s*\(\s*(.*?)\s*\)\s*;", content)[0].split('&')
        # match_declares = re.findall("decl\s*(.*?);", content)
        objects = {}
        declares = {}
        for m in match_types:
            objects[m[0]] = m[1].replace(' ', '').split(',')

        for m in match_declares:
            declares[m[0]] = m[1:]

        curb_len = len(objects['curb'])
        car_len = len(objects['car'])

        inits = ["0" for _ in range(curb_len + car_len)]
        goals = ["0" for _ in range(curb_len + car_len)]
        for m in match_initial:
            match_state = re.findall("\s*(.*?)\(\s*(.*?)\s*\)\s*:=\s*(.*)\s*", m)
            for x in match_state:
                if x[0] == 'carat':
                    car = str(int(x[1].replace('car_', '')) + 1)
                    if 'curb' in x[2]:
                        loc = int(x[2].replace('curb_', '')) + car_len
                    else:
                        loc = int(x[2].replace('car_', ''))

                    inits[loc] = car
                    # print (content.find('type(.*)=(.*){.*)}'))

        for g in match_goal:
            match_state = re.findall("\s*\(\s*(.*?)\s*\(\s*(.*?)\s*\)\s*\)\s*=\s*\(\s*(.*)\s*\)", g)
            for x in match_state:
                if x[0] == 'carat':
                    car = str(int(x[1].replace('car_', '')) + 1)
                    if 'curb' in x[2]:
                        loc = int(x[2].replace('curb_', '')) + car_len
                    else:
                        loc = int(x[2].replace('car_', ''))

                    goals[loc] = car
        # print objects
        # print declares
        print ','.join(inits)
        print ','.join(goals)
        ndl.close()


ndl_to_data("benchmark/parking04.ndl")
